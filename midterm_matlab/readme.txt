AEM 428/528 Midterm MATLAB Project
=================================

This folder contains a MATLAB-oriented rebuild of the missile interception midterm project.

Main file to run:
    run_midterm_project.m

What it does:
- Solves the attack missile launch angle so the missile lands at 50 km.
- Computes throat area, mass flow rate, exit temperature, exit velocity, and time of flight.
- Determines the intercept altitude at x = 49 km.
- Searches defense missile final mass, launch angle, and exit Mach number to minimize intercept time while keeping the intercept error within 0.5 m.
- Produces the six required time-history plots as PNG files.
- Produces a trajectory support plot.
- Writes a report draft and results summary.

Expected output folder on Desktop:
    C:\Users\Keela\Desktop\O'Doherty-Keelan-428-Midterm-MATLAB

Files written there:
- results_summary.txt
- results_summary.json
- AEM428_Midterm_Report_Draft.txt
- midterm_results.mat
- figures\*.png

Important note:
This is written as real MATLAB code. If your MATLAB install supports exportgraphics and modern struct behavior, it should run. If something small breaks, it should be fixable with minor syntax cleanup instead of a total rewrite.

AIAA reminders:
- Use Times New Roman
- Keep text black
- Use 14 pt font
- Include axis labels with units
- Keep figures large
- Include both major and minor grid lines
- Put the problem statement and final answers on page 1
