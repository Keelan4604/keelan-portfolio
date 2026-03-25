function [best, checks] = optimize_defense_missile(targetX, targetY, dt)
% Searches final mass and exit Mach; for each pair solves angle minimizing time
% subject to intercepting within 0.5 m vertically at x = 49 km.

masses = 35:1:60;
machs = 2.0:0.05:3.0;
checks = struct('Mf',{},'Mexit',{},'angle_deg',{},'alt_error_m',{},'tof_s',{});
best.tof = inf;
checkCount = 0;

for i = 1:numel(masses)
    mf = masses(i);
    for j = 1:numel(machs)
        mexit = machs(j);
        angleLo = 1;
        angleHi = 89;
        bestLocalErr = inf;
        bestLocalAngle = NaN;
        bestLocalCross = [];
        bestLocalSim = [];
        bestLocalSpec = [];

        for coarse = linspace(angleLo, angleHi, 181)
            [err, cross, sim, spec] = defense_error(mf, mexit, coarse, targetX, targetY, dt);
            if err < bestLocalErr
                bestLocalErr = err;
                bestLocalAngle = coarse;
                bestLocalCross = cross;
                bestLocalSim = sim;
                bestLocalSpec = spec;
            end
        end

        refineLo = max(1, bestLocalAngle - 1);
        refineHi = min(89, bestLocalAngle + 1);
        for refine = linspace(refineLo, refineHi, 205)
            [err, cross, sim, spec] = defense_error(mf, mexit, refine, targetX, targetY, dt);
            if err < bestLocalErr
                bestLocalErr = err;
                bestLocalAngle = refine;
                bestLocalCross = cross;
                bestLocalSim = sim;
                bestLocalSpec = spec;
            end
        end

        if ~isempty(bestLocalCross) && bestLocalErr <= 0.5
            checkCount = checkCount + 1;
            checks(checkCount).Mf = mf;
            checks(checkCount).Mexit = mexit;
            checks(checkCount).angle_deg = bestLocalAngle;
            checks(checkCount).alt_error_m = bestLocalErr;
            checks(checkCount).tof_s = bestLocalCross.t;

            if bestLocalCross.t < best.tof
                props = nozzle_properties(bestLocalSpec);
                best = struct();
                best.final_mass_kg = mf;
                best.launch_angle_deg_above_negative_x = bestLocalAngle;
                best.equivalent_global_angle_deg = 180 - bestLocalAngle;
                best.exit_mach = mexit;
                best.time_of_flight_to_intercept_s = bestLocalCross.t;
                best.vertical_error_m = bestLocalErr;
                best.throat_area_m2 = props.At;
                best.mass_flow_rate_kg_s = props.mdot;
                best.exit_temperature_K = props.Te;
                best.exit_velocity_m_s = props.ve;
                best.burn_time_s = props.tburn;
                best.tof = bestLocalCross.t;
                best.sim = bestLocalSim;
            end
        end
    end
end

if isfield(best,'tof')
    best = rmfield(best,'tof');
else
    error('No defense missile design satisfied the 0.5 m intercept tolerance.');
end
end
