function sim = simulate_missile(spec, launchAngleDeg, dt, x0, y0, maxTime, stopAtGround)
% Time-marching gravity-turn missile simulation.

if nargin < 7; stopAtGround = true; end
if nargin < 6; maxTime = 400; end
if nargin < 5; y0 = 0; end
if nargin < 4; x0 = 0; end

props = nozzle_properties(spec);
Aref = pi*spec.Dref^2/4;
launchAngle = deg2rad(launchAngleDeg);
g0 = 9.80665;

nmax = floor(maxTime/dt) + 2;
t = zeros(nmax,1);
x = zeros(nmax,1);
y = zeros(nmax,1);
vx = zeros(nmax,1);
vy = zeros(nmax,1);
mass = zeros(nmax,1);
accel = zeros(nmax,1);
thrust = zeros(nmax,1);
path = zeros(nmax,1);

x(1) = x0;
y(1) = y0;
mass(1) = spec.Mi;
path(1) = launchAngle;

k = 1;
while k < nmax
    speed = hypot(vx(k), vy(k));
    if speed > 1e-9
        gammaPath = atan2(vy(k), vx(k));
    else
        gammaPath = launchAngle;
    end

    [~, Patm, rho] = atmosphere_model(y(k), g0);

    if mass(k) > spec.Mf + 1e-12
        dm = props.mdot * dt;
        if mass(k) - dm < spec.Mf
            dm = mass(k) - spec.Mf;
            mdotEff = dm / dt;
        else
            mdotEff = props.mdot;
        end
        thrustNow = mdotEff*props.ve + (props.pe - Patm)*props.Ae;
        massNext = mass(k) - dm;
    else
        thrustNow = 0;
        massNext = mass(k);
    end

    drag = 0.5 * rho * speed^2 * spec.Cd * Aref;
    ax = (thrustNow - drag)*cos(gammaPath)/mass(k);
    ay = (thrustNow - drag)*sin(gammaPath)/mass(k) - g0;

    vxNext = vx(k) + ax*dt;
    vyNext = vy(k) + ay*dt;
    xNext = x(k) + vxNext*dt;
    yNext = y(k) + vyNext*dt;

    k = k + 1;
    t(k) = t(k-1) + dt;
    x(k) = xNext;
    y(k) = yNext;
    vx(k) = vxNext;
    vy(k) = vyNext;
    mass(k) = massNext;
    accel(k) = hypot(ax, ay);
    thrust(k) = thrustNow;
    path(k) = gammaPath;

    if stopAtGround && y(k) < 0 && t(k) > dt
        break;
    end
    if abs(x(k)) > 1e6 || y(k) > 2e5
        break;
    end
end

fields = {'t','x','y','vx','vy','mass','accel','thrust','path_angle_rad'};
values = {t(1:k),x(1:k),y(1:k),vx(1:k),vy(1:k),mass(1:k),accel(1:k),thrust(1:k),path(1:k)};
for i = 1:numel(fields)
    sim.(fields{i}) = values{i};
end
sim.path_angle_deg = rad2deg(sim.path_angle_rad);
sim.props = props;
end
