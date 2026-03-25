function savejson_fallback(results, filePath)
% Writes a simple JSON-like text file from known scalar fields.

fid = fopen(filePath,'w');
fprintf(fid,'{\n');
fprintf(fid,'  "dt_s": %.10f,\n', results.dt_s);
fprintf(fid,'  "attack": {\n');
fprintf(fid,'    "throat_area_m2": %.12f,\n', results.attack.throat_area_m2);
fprintf(fid,'    "mass_flow_rate_kg_s": %.12f,\n', results.attack.mass_flow_rate_kg_s);
fprintf(fid,'    "exit_temperature_K": %.12f,\n', results.attack.exit_temperature_K);
fprintf(fid,'    "exit_velocity_m_s": %.12f,\n', results.attack.exit_velocity_m_s);
fprintf(fid,'    "launch_angle_deg": %.12f,\n', results.attack.launch_angle_deg);
fprintf(fid,'    "time_of_flight_s": %.12f,\n', results.attack.time_of_flight_s);
fprintf(fid,'    "range_m": %.12f,\n', results.attack.range_m);
fprintf(fid,'    "intercept_x_m": %.12f,\n', results.attack.intercept_x_m);
fprintf(fid,'    "intercept_y_m": %.12f,\n', results.attack.intercept_y_m);
fprintf(fid,'    "intercept_time_s": %.12f,\n', results.attack.intercept_time_s);
fprintf(fid,'    "burn_time_s": %.12f\n', results.attack.burn_time_s);
fprintf(fid,'  },\n');
fprintf(fid,'  "defense": {\n');
fprintf(fid,'    "final_mass_kg": %.12f,\n', results.defense.final_mass_kg);
fprintf(fid,'    "launch_angle_deg_above_negative_x": %.12f,\n', results.defense.launch_angle_deg_above_negative_x);
fprintf(fid,'    "equivalent_global_angle_deg": %.12f,\n', results.defense.equivalent_global_angle_deg);
fprintf(fid,'    "exit_mach": %.12f,\n', results.defense.exit_mach);
fprintf(fid,'    "time_of_flight_to_intercept_s": %.12f,\n', results.defense.time_of_flight_to_intercept_s);
fprintf(fid,'    "vertical_error_m": %.12f,\n', results.defense.vertical_error_m);
fprintf(fid,'    "launch_delay_after_attack_s": %.12f,\n', results.defense.launch_delay_after_attack_s);
fprintf(fid,'    "throat_area_m2": %.12f,\n', results.defense.throat_area_m2);
fprintf(fid,'    "mass_flow_rate_kg_s": %.12f,\n', results.defense.mass_flow_rate_kg_s);
fprintf(fid,'    "exit_temperature_K": %.12f,\n', results.defense.exit_temperature_K);
fprintf(fid,'    "exit_velocity_m_s": %.12f,\n', results.defense.exit_velocity_m_s);
fprintf(fid,'    "burn_time_s": %.12f\n', results.defense.burn_time_s);
fprintf(fid,'  }\n');
fprintf(fid,'}\n');
fclose(fid);
end
