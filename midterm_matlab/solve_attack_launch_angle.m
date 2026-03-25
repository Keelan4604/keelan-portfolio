function [bestAngle, bestSim] = solve_attack_launch_angle(spec, targetRange, dt)
% Brackets and solves for attack missile launch angle yielding 50 km range.

angles = linspace(2, 88, 44);
prevAngle = angles(1);
prevSim = simulate_missile(spec, prevAngle, dt, 0, 0, 400, true);
prevF = impact_range(prevSim) - targetRange;
lo = NaN; hi = NaN;

for idx = 2:numel(angles)
    ang = angles(idx);
    sim = simulate_missile(spec, ang, dt, 0, 0, 400, true);
    f = impact_range(sim) - targetRange;
    if prevF * f <= 0
        lo = prevAngle;
        hi = ang;
        break;
    end
    prevAngle = ang;
    prevSim = sim;
    prevF = f;
end

if isnan(lo)
    error('Could not bracket attack launch angle.');
end

simLo = simulate_missile(spec, lo, dt, 0, 0, 400, true);
fLo = impact_range(simLo) - targetRange;

for iter = 1:40
    mid = 0.5*(lo + hi);
    simMid = simulate_missile(spec, mid, dt, 0, 0, 400, true);
    fMid = impact_range(simMid) - targetRange;
    if abs(fMid) < 1e-3
        bestAngle = mid;
        bestSim = simMid;
        return;
    end
    if fLo * fMid <= 0
        hi = mid;
    else
        lo = mid;
        fLo = fMid;
    end
end

bestAngle = 0.5*(lo + hi);
bestSim = simulate_missile(spec, bestAngle, dt, 0, 0, 400, true);
end
