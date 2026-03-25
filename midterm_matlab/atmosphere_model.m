function [Tatm, Patm, rho] = atmosphere_model(h, g0)
% Standard atmosphere model used in the exam prompt.

Tsl = 288.15;
Psl = 101325;
L = 0.0065;
Rair = 287.0;

h = max(0,h);
if h <= 11000
    Tatm = Tsl - L*h;
    Patm = Psl * (Tatm/Tsl)^(g0/(Rair*L));
else
    Tatm = 216.65;
    P11 = Psl * (Tatm/Tsl)^(g0/(Rair*L));
    Patm = P11 * exp(-g0*(h-11000)/(Rair*Tatm));
end
rho = Patm/(Rair*Tatm);
end
