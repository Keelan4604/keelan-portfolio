function results = run_midterm_project()
% AEM 428/528 Midterm Project - MATLAB solution driver
% Keelan O'Doherty / regenerated project workspace

clc;
clearvars;
close all;

outDir = 'C:\\Users\\Keela\\Desktop\\O''Doherty-Keelan-428-Midterm-MATLAB';
figDir = fullfile(outDir,'figures');
if ~exist(outDir,'dir'); mkdir(outDir); end
if ~exist(figDir,'dir'); mkdir(figDir); end

set(groot,'defaultAxesFontName','Times New Roman');
set(groot,'defaultTextFontName','Times New Roman');
set(groot,'defaultAxesFontSize',14);
set(groot,'defaultTextFontSize',14);
set(groot,'defaultLegendFontSize',14);

params.g0 = 9.80665;
params.dt = 1.0e-4;
params.targetRange = 50e3;
params.interceptX = 49e3;

attack = struct( ...
    'Mi',1670, ...
    'Mf',570, ...
    'Cd',0.45, ...
    'Dref',0.61, ...
    'P0',101325*20, ...
    'T0',2500, ...
    'Dexit',0.58, ...
    'gamma',1.24, ...
    'Rgas',350, ...
    'Mexit',3.0);

[attackAngle, attackSim] = solve_attack_launch_angle(attack, params.targetRange, params.dt);
attackCross = interpolate_crossing(attackSim.x, attackSim.y, attackSim.t, params.interceptX);

attackResults = struct();
attackResults.throat_area_m2 = attackSim.props.At;
attackResults.mass_flow_rate_kg_s = attackSim.props.mdot;
attackResults.exit_temperature_K = attackSim.props.Te;
attackResults.exit_velocity_m_s = attackSim.props.ve;
attackResults.launch_angle_deg = attackAngle;
attackResults.time_of_flight_s = impact_time(attackSim);
attackResults.range_m = impact_range(attackSim);
attackResults.intercept_x_m = params.interceptX;
attackResults.intercept_y_m = attackCross.y;
attackResults.intercept_time_s = attackCross.t;
attackResults.burn_time_s = attackSim.props.tburn;

plot_attack_time_histories(attackSim, figDir);
plot_attack_and_intercept(attackSim, params.interceptX, attackCross.y, figDir);

[defenseBest, defenseChecks] = optimize_defense_missile(params.interceptX, attackCross.y, params.dt);
launchDelay = attackCross.t - defenseBest.time_of_flight_to_intercept_s;

results = struct();
results.dt_s = params.dt;
results.attack = attackResults;
results.defense = defenseBest;
results.defense.launch_delay_after_attack_s = launchDelay;
results.defense_local_checks = defenseChecks;

save(fullfile(outDir,'midterm_results.mat'),'results','attackSim');
write_results_text(results, fullfile(outDir,'results_summary.txt'));
write_report_text(results, fullfile(outDir,'AEM428_Midterm_Report_Draft.txt'));
savejson_fallback(results, fullfile(outDir,'results_summary.json'));

fprintf('Project complete. Files written to:\n%s\n', outDir);
fprintf('Recommended defense launch delay after attack launch: %.6f s\n', launchDelay);
end
