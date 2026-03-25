function xImpact = impact_range(sim)
% Interpolated impact range at y = 0.

y = sim.y;
x = sim.x;
if y(end) >= 0
    xImpact = x(end);
    return;
end

i = numel(y)-1;
y1 = y(i); y2 = y(i+1);
x1 = x(i); x2 = x(i+1);
if y2 == y1
    frac = 0;
else
    frac = -y1/(y2-y1);
end
xImpact = x1 + frac*(x2-x1);
end
