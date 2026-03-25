function props = nozzle_properties(spec)
% Computes ideal nozzle/choked flow properties.

Ae = pi*spec.Dexit^2/4;
g = spec.gamma;
M = spec.Mexit;
areaRatio = (1/M) * ((2/(g+1))*(1+0.5*(g-1)*M^2))^((g+1)/(2*(g-1)));
At = Ae/areaRatio;
mdot = At*spec.P0/sqrt(spec.T0) * sqrt(g/spec.Rgas) * (2/(g+1))^((g+1)/(2*(g-1)));
Te = spec.T0/(1+0.5*(g-1)*M^2);
pe = spec.P0/(1+0.5*(g-1)*M^2)^(g/(g-1));
ve = M*sqrt(g*spec.Rgas*Te);
tburn = (spec.Mi - spec.Mf)/mdot;

props = struct('Ae',Ae,'areaRatio',areaRatio,'At',At,'mdot',mdot,'Te',Te,'pe',pe,'ve',ve,'tburn',tburn);
end
