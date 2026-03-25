import math
from dataclasses import dataclass
from typing import Dict, Tuple

import numpy as np

try:
    from numba import njit
except Exception:  # pragma: no cover
    def njit(*args, **kwargs):
        def deco(fn):
            return fn
        if args and callable(args[0]):
            return args[0]
        return deco

G0 = 9.80665
T_SL = 288.15
P_SL = 101325.0
LAPSE = 0.0065
R_AIR = 287.0


@dataclass
class MissileSpec:
    Mi: float
    Mf: float
    Cd: float
    Dref: float
    P0: float
    T0: float
    Dexit: float
    gamma: float
    Rgas: float
    Mexit: float


@njit(cache=True)
def atmosphere_numba(h: float):
    h = max(0.0, float(h))
    if h <= 11000.0:
        Tatm = T_SL - LAPSE * h
        Patm = P_SL * (Tatm / T_SL) ** (G0 / (R_AIR * LAPSE))
    else:
        Tatm = 216.65
        P11 = P_SL * (Tatm / T_SL) ** (G0 / (R_AIR * LAPSE))
        Patm = P11 * math.exp(-G0 * (h - 11000.0) / (R_AIR * Tatm))
    rho = Patm / (R_AIR * Tatm)
    return Tatm, Patm, rho


def atmosphere(h: float) -> Tuple[float, float, float]:
    return atmosphere_numba(h)


@njit(cache=True)
def nozzle_properties_numba(Mi, Mf, P0, T0, Dexit, gamma, Rgas, Mexit):
    Ae = math.pi * Dexit ** 2 / 4.0
    g = gamma
    M = Mexit
    area_ratio = (1.0 / M) * ((2.0 / (g + 1.0)) * (1.0 + 0.5 * (g - 1.0) * M * M)) ** ((g + 1.0) / (2.0 * (g - 1.0)))
    At = Ae / area_ratio
    mdot = At * P0 / math.sqrt(T0) * math.sqrt(g / Rgas) * (2.0 / (g + 1.0)) ** ((g + 1.0) / (2.0 * (g - 1.0)))
    Te = T0 / (1.0 + 0.5 * (g - 1.0) * M * M)
    pe = P0 / (1.0 + 0.5 * (g - 1.0) * M * M) ** (g / (g - 1.0))
    ve = M * math.sqrt(g * Rgas * Te)
    tburn = (Mi - Mf) / mdot
    return Ae, area_ratio, At, mdot, Te, pe, ve, tburn


def nozzle_properties(spec: MissileSpec) -> Dict[str, float]:
    Ae, area_ratio, At, mdot, Te, pe, ve, tburn = nozzle_properties_numba(spec.Mi, spec.Mf, spec.P0, spec.T0, spec.Dexit, spec.gamma, spec.Rgas, spec.Mexit)
    return {'Ae': Ae, 'area_ratio': area_ratio, 'At': At, 'mdot': mdot, 'Te': Te, 'pe': pe, 've': ve, 'tburn': tburn}


@njit(cache=True)
def simulate_missile_numba(Mi, Mf, Cd, Dref, P0, T0, Dexit, gamma, Rgas, Mexit, launch_angle_deg, dt, x0, y0, max_time, stop_at_ground):
    Ae, area_ratio, At, mdot_nom, Te, pe, ve, tburn = nozzle_properties_numba(Mi, Mf, P0, T0, Dexit, gamma, Rgas, Mexit)
    Aref = math.pi * Dref ** 2 / 4.0
    launch_angle = math.radians(launch_angle_deg)

    nmax = int(max_time / dt) + 2
    t = np.empty(nmax)
    x = np.empty(nmax)
    y = np.empty(nmax)
    vx = np.empty(nmax)
    vy = np.empty(nmax)
    mass = np.empty(nmax)
    accel = np.empty(nmax)
    thrust = np.empty(nmax)
    path = np.empty(nmax)

    t[0] = 0.0
    x[0] = x0
    y[0] = y0
    vx[0] = 0.0
    vy[0] = 0.0
    mass[0] = Mi
    accel[0] = 0.0
    thrust[0] = 0.0
    path[0] = launch_angle

    k = 0
    while k < nmax - 1:
        speed = math.hypot(vx[k], vy[k])
        if speed > 1e-9:
            gamma_path = math.atan2(vy[k], vx[k])
        else:
            gamma_path = launch_angle

        _, Patm, rho = atmosphere_numba(y[k])

        if mass[k] > Mf + 1e-12:
            dm = mdot_nom * dt
            if mass[k] - dm < Mf:
                dm = mass[k] - Mf
                mdot_eff = dm / dt
            else:
                mdot_eff = mdot_nom
            thrust_now = mdot_eff * ve + (pe - Patm) * Ae
            mass_next = mass[k] - dm
        else:
            thrust_now = 0.0
            mass_next = mass[k]

        drag = 0.5 * rho * speed * speed * Cd * Aref
        ax = (thrust_now - drag) * math.cos(gamma_path) / mass[k]
        ay = (thrust_now - drag) * math.sin(gamma_path) / mass[k] - G0

        vx_next = vx[k] + ax * dt
        vy_next = vy[k] + ay * dt
        x_next = x[k] + vx_next * dt
        y_next = y[k] + vy_next * dt

        k += 1
        t[k] = t[k - 1] + dt
        x[k] = x_next
        y[k] = y_next
        vx[k] = vx_next
        vy[k] = vy_next
        mass[k] = mass_next
        accel[k] = math.hypot(ax, ay)
        thrust[k] = thrust_now
        path[k] = gamma_path

        if stop_at_ground and y[k] < 0.0 and t[k] > dt:
            break
        if abs(x[k]) > 1e6 or y[k] > 2e5:
            break

    return t[:k + 1], x[:k + 1], y[:k + 1], vx[:k + 1], vy[:k + 1], mass[:k + 1], accel[:k + 1], thrust[:k + 1], path[:k + 1], Ae, area_ratio, At, mdot_nom, Te, pe, ve, tburn


def simulate_missile(spec: MissileSpec, launch_angle_deg: float, dt: float = 1e-4, x0: float = 0.0, y0: float = 0.0,
                     max_time: float = 400.0, stop_at_ground: bool = True) -> Dict[str, np.ndarray]:
    vals = simulate_missile_numba(spec.Mi, spec.Mf, spec.Cd, spec.Dref, spec.P0, spec.T0, spec.Dexit, spec.gamma, spec.Rgas, spec.Mexit,
                                  launch_angle_deg, dt, x0, y0, max_time, stop_at_ground)
    t, x, y, vx, vy, mass, accel, thrust, path, Ae, area_ratio, At, mdot, Te, pe, ve, tburn = vals
    return {
        't': t,
        'x': x,
        'y': y,
        'vx': vx,
        'vy': vy,
        'mass': mass,
        'accel': accel,
        'thrust': thrust,
        'path_angle_rad': path,
        'path_angle_deg': np.degrees(path),
        'props': {'Ae': Ae, 'area_ratio': area_ratio, 'At': At, 'mdot': mdot, 'Te': Te, 'pe': pe, 've': ve, 'tburn': tburn},
    }


def interpolate_crossing(x: np.ndarray, y: np.ndarray, t: np.ndarray, target_x: float):
    if (target_x < float(np.min(x))) or (target_x > float(np.max(x))):
        return None
    idx = np.where((x[:-1] - target_x) * (x[1:] - target_x) <= 0)[0]
    if len(idx) == 0:
        return None
    i = int(idx[0])
    x1, x2 = x[i], x[i + 1]
    frac = 0.0 if x2 == x1 else (target_x - x1) / (x2 - x1)
    yc = y[i] + frac * (y[i + 1] - y[i])
    tc = t[i] + frac * (t[i + 1] - t[i])
    return {'t': tc, 'y': yc, 'i': i, 'frac': frac}


def impact_range(sim: Dict[str, np.ndarray]) -> float:
    x = sim['x']
    y = sim['y']
    if y[-1] >= 0.0:
        return float(x[-1])
    i = len(y) - 2
    y1, y2 = y[i], y[i + 1]
    x1, x2 = x[i], x[i + 1]
    frac = 0.0 if y2 == y1 else -y1 / (y2 - y1)
    return float(x1 + frac * (x2 - x1))


def impact_time(sim: Dict[str, np.ndarray]) -> float:
    y = sim['y']
    t = sim['t']
    if y[-1] >= 0.0:
        return float(t[-1])
    i = len(y) - 2
    y1, y2 = y[i], y[i + 1]
    t1, t2 = t[i], t[i + 1]
    frac = 0.0 if y2 == y1 else -y1 / (y2 - y1)
    return float(t1 + frac * (t2 - t1))


def solve_attack_launch_angle(spec: MissileSpec, target_range: float = 50_000.0, dt: float = 1e-4):
    angles = np.linspace(2.0, 88.0, 44)
    prev_angle = float(angles[0])
    prev_sim = simulate_missile(spec, prev_angle, dt=dt)
    prev_f = impact_range(prev_sim) - target_range
    lo = hi = None
    sim_lo = sim_hi = None
    for ang in angles[1:]:
        ang = float(ang)
        sim = simulate_missile(spec, ang, dt=dt)
        f = impact_range(sim) - target_range
        if prev_f * f <= 0:
            lo, hi = prev_angle, ang
            sim_lo, sim_hi = prev_sim, sim
            break
        prev_angle, prev_sim, prev_f = ang, sim, f
    if lo is None:
        raise RuntimeError('Could not bracket attack launch angle.')
    f_lo = impact_range(sim_lo) - target_range
    for _ in range(40):
        mid = 0.5 * (lo + hi)
        sim_mid = simulate_missile(spec, mid, dt=dt)
        f_mid = impact_range(sim_mid) - target_range
        if abs(f_mid) < 1e-3:
            return mid, sim_mid
        if f_lo * f_mid <= 0:
            hi = mid
        else:
            lo = mid
            f_lo = f_mid
    mid = 0.5 * (lo + hi)
    return mid, simulate_missile(spec, mid, dt=dt)


def defense_error(mf: float, mexit: float, angle_deg: float, target_x: float, target_y: float, dt: float = 1e-4):
    spec = MissileSpec(Mi=70.0, Mf=mf, Cd=0.45, Dref=0.15, P0=101325.0 * 20.0, T0=2500.0, Dexit=0.13, gamma=1.24, Rgas=350.0, Mexit=mexit)
    sim = simulate_missile(spec, 180.0 - angle_deg, dt=dt, x0=50_000.0, y0=0.0, max_time=60.0)
    cross = interpolate_crossing(sim['x'], sim['y'], sim['t'], target_x)
    if cross is None:
        return 1e9, None, sim, spec
    err = abs(cross['y'] - target_y)
    return err, cross, sim, spec
