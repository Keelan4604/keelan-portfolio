function write_report_text(results, filePath)
% Generates a report draft in plain text with AIAA-style content guidance.

fid = fopen(filePath,'w');
fprintf(fid,'AEM 428/528 Midterm Exam Report Draft\n');
fprintf(fid,'Keelan O''Doherty\n\n');

fprintf(fid,'Problem Statement\n');
fprintf(fid,'This project analyzes an incoming attack missile launched toward a target 50 km away and a lighter defensive missile launched from the target location to intercept the attacker at x = 49 km. The attack missile trajectory is modeled as a gravity-turn flight with variable atmospheric properties, drag, changing mass during propellant burn, and thrust based on choked nozzle flow. The defensive missile is modeled using the same physics, and its final mass, launch angle, and exit Mach number are selected to minimize intercept time while achieving an intercept point within 0.5 m of the required altitude.\n\n');

fprintf(fid,'Requested Numerical Results\n');
fprintf(fid,'Attack missile throat area: %.6f m^2\n', results.attack.throat_area_m2);
fprintf(fid,'Attack missile propellant mass flow rate: %.6f kg/s\n', results.attack.mass_flow_rate_kg_s);
fprintf(fid,'Attack missile exit temperature: %.6f K\n', results.attack.exit_temperature_K);
fprintf(fid,'Attack missile exit velocity: %.6f m/s\n', results.attack.exit_velocity_m_s);
fprintf(fid,'Attack missile launch angle: %.6f deg\n', results.attack.launch_angle_deg);
fprintf(fid,'Attack missile time of flight: %.6f s\n', results.attack.time_of_flight_s);
fprintf(fid,'Intercept altitude at x = 49 km: %.6f m\n', results.attack.intercept_y_m);
fprintf(fid,'Attack missile time at x = 49 km: %.6f s\n\n', results.attack.intercept_time_s);

fprintf(fid,'Defense missile final mass: %.6f kg\n', results.defense.final_mass_kg);
fprintf(fid,'Defense missile launch angle above negative x-axis: %.6f deg\n', results.defense.launch_angle_deg_above_negative_x);
fprintf(fid,'Defense missile equivalent global launch angle: %.6f deg\n', results.defense.equivalent_global_angle_deg);
fprintf(fid,'Defense missile exit Mach number: %.6f\n', results.defense.exit_mach);
fprintf(fid,'Defense missile time of flight to intercept: %.6f s\n', results.defense.time_of_flight_to_intercept_s);
fprintf(fid,'Defense missile vertical intercept error: %.6f m\n', results.defense.vertical_error_m);
fprintf(fid,'Recommended defense launch delay after attack launch: %.6f s\n\n', results.defense.launch_delay_after_attack_s);

fprintf(fid,'Method Summary\n');
fprintf(fid,'1. Use isentropic nozzle relations to compute nozzle throat area, mass flow rate, exit temperature, exit pressure, exit velocity, and burn time.\n');
fprintf(fid,'2. Propagate the equations of motion using dt = 0.0001 s. At each step, compute atmospheric temperature, pressure, and density from the piecewise standard atmosphere supplied in the exam statement.\n');
fprintf(fid,'3. Use a gravity-turn assumption so thrust and velocity remain aligned after motion begins. Compute drag from the instantaneous dynamic pressure and the reference area.\n');
fprintf(fid,'4. For the attack missile, solve for the launch angle that produces a 50 km impact range. Then interpolate the altitude and time when the missile reaches x = 49 km.\n');
fprintf(fid,'5. For the defense missile, search the allowable final mass and exit Mach number ranges and determine the launch angle that minimizes altitude error at x = 49 km. Keep only solutions that satisfy the 0.5 m intercept tolerance and choose the one with the shortest time of flight.\n\n');

fprintf(fid,'Figures to Include\n');
fprintf(fid,'1. Path angle versus time\n');
fprintf(fid,'2. Elevation versus time\n');
fprintf(fid,'3. x-velocity versus time\n');
fprintf(fid,'4. y-velocity versus time\n');
fprintf(fid,'5. Acceleration versus time\n');
fprintf(fid,'6. Thrust versus time\n');
fprintf(fid,'7. Optional supporting trajectory figure showing the attack missile path and intercept location\n\n');

fprintf(fid,'AIAA Formatting Notes\n');
fprintf(fid,'- Use Times New Roman, 14 pt, black text only.\n');
fprintf(fid,'- Keep figures at least half a page in size.\n');
fprintf(fid,'- Label both axes clearly with units.\n');
fprintf(fid,'- Include major and minor grid lines.\n');
fprintf(fid,'- Use logical axis limits so the data occupies most of each figure.\n');
fprintf(fid,'- Put the problem statement, a simple missile/intercept sketch, and the final requested variables on the first page.\n\n');

fprintf(fid,'Suggested Discussion Paragraph\n');
fprintf(fid,'The attack missile required a steep launch angle because the modeled propulsion system produces a large thrust level and a long-range ballistic trajectory. The resulting intercept altitude at x = 49 km was relatively low compared with the full apogee because the missile was already descending toward the target. For the defense missile, the optimization favored the lightest dry mass and the lowest allowed exit Mach number because those values produced the shortest feasible time to reach the required intercept point while still satisfying the strict 0.5 m miss-distance criterion.\n');

fclose(fid);
end
