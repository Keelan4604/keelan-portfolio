function plot_attack_and_intercept(attackSim, interceptX, interceptY, figDir)
% Helpful extra trajectory plot.

fig = figure('Color','w','Units','normalized','Position',[0.1 0.1 0.7 0.7]);
plot(attackSim.x/1000, attackSim.y/1000, 'k-', 'LineWidth', 1.8);
hold on;
plot(interceptX/1000, interceptY/1000, 'ko', 'MarkerFaceColor','k', 'MarkerSize',7);
plot([50 50],[0 max(attackSim.y)/1000], 'k--', 'LineWidth', 1.0);
plot([49 49],[0 max(attackSim.y)/1000], 'k:', 'LineWidth', 1.2);
xlabel('Downrange distance, km');
ylabel('Altitude, km');
title('Attack Missile Trajectory and Intercept Point','FontWeight','normal','Color','k');
legend('Attack missile trajectory','Intercept point','Target location','Intercept x-location','Location','best');
grid on; grid minor;
ax = gca;
ax.FontName = 'Times New Roman';
ax.FontSize = 14;
ax.XColor = 'k'; ax.YColor = 'k';
axis tight;
exportgraphics(fig, fullfile(figDir,'attack_trajectory_with_intercept.png'), 'Resolution', 300);
end
