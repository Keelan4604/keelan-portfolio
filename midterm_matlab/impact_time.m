function tImpact = impact_time(sim)
% Interpolated impact time at y = 0.

y = sim.y;
t = sim.t;
if y(end) >= 0
    tImpact = t(end);
    return;
end

i = numel(y)-1;
y1 = y(i); y2 = y(i+1);
t1 = t(i); t2 = t(i+1);
if y2 == y1
    frac = 0;
else
    frac = -y1/(y2-y1);
end
tImpact = t1 + frac*(t2-t1);
end
