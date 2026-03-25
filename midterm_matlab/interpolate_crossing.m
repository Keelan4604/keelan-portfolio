function cross = interpolate_crossing(x, y, t, targetX)
% Linear interpolation to the point where x crosses targetX.

cross = [];
for i = 1:(numel(x)-1)
    if (x(i)-targetX)*(x(i+1)-targetX) <= 0
        if x(i+1) == x(i)
            frac = 0;
        else
            frac = (targetX - x(i)) / (x(i+1) - x(i));
        end
        cross.t = t(i) + frac*(t(i+1)-t(i));
        cross.y = y(i) + frac*(y(i+1)-y(i));
        cross.index = i;
        cross.frac = frac;
        return;
    end
end
end
