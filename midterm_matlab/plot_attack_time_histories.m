function plot_attack_time_histories(sim, figDir)
% Creates the six required time-history plots.

make_plot(sim.t, sim.path_angle_deg, 'Time, s', 'Path angle, deg', ...
    'Attack Missile Path Angle vs. Time', fullfile(figDir,'attack_path_angle_vs_time.png'));
make_plot(sim.t, sim.y, 'Time, s', 'Elevation, m', ...
    'Attack Missile Elevation vs. Time', fullfile(figDir,'attack_elevation_vs_time.png'));
make_plot(sim.t, sim.vx, 'Time, s', 'x-Velocity, m/s', ...
    'Attack Missile x-Velocity vs. Time', fullfile(figDir,'attack_vx_vs_time.png'));
make_plot(sim.t, sim.vy, 'Time, s', 'y-Velocity, m/s', ...
    'Attack Missile y-Velocity vs. Time', fullfile(figDir,'attack_vy_vs_time.png'));
make_plot(sim.t, sim.accel, 'Time, s', 'Acceleration, m/s^2', ...
    'Attack Missile Acceleration vs. Time', fullfile(figDir,'attack_acceleration_vs_time.png'));
make_plot(sim.t, sim.thrust, 'Time, s', 'Thrust, N', ...
    'Attack Missile Thrust vs. Time', fullfile(figDir,'attack_thrust_vs_time.png'));
end

function make_plot(x, y, xlab, ylab, ttl, filePath)
fig = figure('Color','w','Units','normalized','Position',[0.1 0.1 0.7 0.7]);
plot(x, y, 'k-', 'LineWidth', 1.6);
xlabel(xlab,'Color','k');
ylabel(ylab,'Color','k');
title(ttl,'Color','k','FontWeight','normal');
grid on;
grid minor;
ax = gca;
ax.FontName = 'Times New Roman';
ax.FontSize = 14;
ax.XColor = 'k';
ax.YColor = 'k';
ax.GridColor = [0.6 0.6 0.6];
ax.MinorGridColor = [0.8 0.8 0.8];
ax.LineWidth = 1.0;
axis tight;
exportgraphics(fig, filePath, 'Resolution', 300);
end
