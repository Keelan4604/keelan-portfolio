function write_results_text(results, filePath)
% Writes a plain-text summary of numerical answers.

fid = fopen(filePath,'w');
fprintf(fid,'AEM 428/528 Midterm Results Summary\n');
fprintf(fid,'=================================\n\n');
fprintf(fid,'Time step, dt = %.7f s\n\n', results.dt_s);

fprintf(fid,'ATTACK MISSILE\n');
fprintf(fid,'--------------\n');
fprintf(fid,'Throat area, At = %.12f m^2\n', results.attack.throat_area_m2);
fprintf(fid,'Mass flow rate, mdot = %.12f kg/s\n', results.attack.mass_flow_rate_kg_s);
fprintf(fid,'Exit temperature, Te = %.12f K\n', results.attack.exit_temperature_K);
fprintf(fid,'Exit velocity, ve = %.12f m/s\n', results.attack.exit_velocity_m_s);
fprintf(fid,'Launch angle = %.12f deg\n', results.attack.launch_angle_deg);
fprintf(fid,'Time of flight = %.12f s\n', results.attack.time_of_flight_s);
fprintf(fid,'Range = %.12f m\n', results.attack.range_m);
fprintf(fid,'Intercept point = (%.12f m, %.12f m)\n', results.attack.intercept_x_m, results.attack.intercept_y_m);
fprintf(fid,'Attack missile time at x = 49 km = %.12f s\n', results.attack.intercept_time_s);
fprintf(fid,'Burn time = %.12f s\n\n', results.attack.burn_time_s);

fprintf(fid,'DEFENSE MISSILE\n');
fprintf(fid,'---------------\n');
fprintf(fid,'Final mass = %.12f kg\n', results.defense.final_mass_kg);
fprintf(fid,'Launch angle above negative x-axis = %.12f deg\n', results.defense.launch_angle_deg_above_negative_x);
fprintf(fid,'Equivalent global launch angle = %.12f deg\n', results.defense.equivalent_global_angle_deg);
fprintf(fid,'Exit Mach number = %.12f\n', results.defense.exit_mach);
fprintf(fid,'Time of flight to intercept = %.12f s\n', results.defense.time_of_flight_to_intercept_s);
fprintf(fid,'Vertical intercept error = %.12f m\n', results.defense.vertical_error_m);
fprintf(fid,'Launch delay after attack launch = %.12f s\n', results.defense.launch_delay_after_attack_s);
fprintf(fid,'Throat area, At = %.12f m^2\n', results.defense.throat_area_m2);
fprintf(fid,'Mass flow rate, mdot = %.12f kg/s\n', results.defense.mass_flow_rate_kg_s);
fprintf(fid,'Exit temperature, Te = %.12f K\n', results.defense.exit_temperature_K);
fprintf(fid,'Exit velocity, ve = %.12f m/s\n', results.defense.exit_velocity_m_s);
fprintf(fid,'Burn time = %.12f s\n', results.defense.burn_time_s);

fclose(fid);
end
