% AEM 428 Space Propulsion Project 1
% Keelan O'Doherty

clc;
clear;
close all;

geomFile = 'Mach 3.0.txt';

k = 1.4;
R = 287;

T0_in = 3000;
p0_abs = 50e6 + 101325;

f_fric = 0.005;
qT0 = 30;

x0 = 1e-6;
M0 = 1 + 1e-4;

dx = 1e-4;
M2_floor = 1 + 1e-10;
max_halves = 20;

raw = readmatrix(geomFile);
x = raw(:,1);
r = raw(:,2);

[x,iu] = unique(x,'stable');
r = r(iu);
x = x - min(x);
L = max(x);

xg = (0:dx:L).';

rg = pchip(x, r, xg);

drdx = gradient(rg, xg);
d2rdx2 = gradient(drdx, xg);

A = pi*rg.^2;
dAdx = 2*pi*rg.*drdx;
d2Adx2 = 2*pi*(drdx.^2 + rg.*d2rdx2);

D = 2*rg;

dlnA_dx = dAdx./A;
d2lnA_dx2 = (d2Adx2./A) - (dAdx./A).^2;

Astar = A(1);
mdot = p0_abs*Astar*sqrt(k/(R*T0_in)) * (2/(k+1))^((k+1)/(2*(k-1)));

cases = { ...
    struct('name','A: isentropic', 'f',0.0,    'q',0.0); ...
    struct('name','B: friction',   'f',f_fric, 'q',0.0); ...
    struct('name','C: heat',       'f',0.0,    'q',qT0); ...
    struct('name','D: both',       'f',f_fric, 'q',qT0) };

sol = struct([]);

idx0 = find(xg >= x0, 1, 'first');

for c = 1:numel(cases)
    f = cases{c}.f;
    q = cases{c}.q;

    T0 = T0_in + q.*xg;

    if q == 0
        dlnT0_dx = zeros(size(xg));
        d2lnT0_dx2 = zeros(size(xg));
    else
        dlnT0_dx = q ./ T0;
        d2lnT0_dx2 = -(q.^2) ./ (T0.^2);
    end

    S = 4*f ./ D;
    dSdx = gradient(S, xg);

    M2 = nan(size(xg));
    M2(idx0) = M0^2;

    for i = idx0:(numel(xg)-1)
        Mi2 = M2(i);
        if ~isfinite(Mi2)
            break
        end

        dx_local = dx;
        ok = false;

        for h = 1:max_halves
            dM2dx = shapiro_dM2dx_branch(Mi2, k, ...
                dlnA_dx(i), dlnT0_dx(i), S(i), ...
                d2lnA_dx2(i), d2lnT0_dx2(i), dSdx(i));

            M2_try = Mi2 + dM2dx*dx_local;

            if M2_try > M2_floor && isfinite(M2_try)
                ok = true;
                break
            else
                dx_local = dx_local/2;
            end
        end

        if ~ok
            M2(i+1) = Mi2;
        else
            M2(i+1) = M2_try;
        end
    end

    M = sqrt(M2);

    T = T0 ./ (1 + (k-1)/2 .* M.^2);
    a = sqrt(k*R*T);
    V = M .* a;

    rho = mdot ./ (A .* V);
    p = rho .* R .* T;

    sol(c).name = cases{c}.name;
    sol(c).x = xg;
    sol(c).M = M;
    sol(c).T = T;
    sol(c).p = p;
end

figure(1);
clf;
grid on;
hold on;
for i = 1:numel(sol)
    plot(sol(i).x, sol(i).M, 'LineWidth', 1.5);
end
xlabel('x (m)');
ylabel('M');
title('Mach number vs x (Cases A–D)');
xline(0,'--');
legend({sol.name}, 'Location','best');

figure(2);
clf;
grid on;
hold on;
for i = 1:numel(sol)
    plot(sol(i).x, sol(i).T, 'LineWidth', 1.5);
end
xlabel('x (m)');
ylabel('T (K)');
title('Temperature vs x (Cases A–D)');
xline(0,'--');
legend({sol.name}, 'Location','best');

figure(3);
clf;
grid on;
hold on;
for i = 1:numel(sol)
    semilogy(sol(i).x, sol(i).p, 'LineWidth', 1.5);
end
xlabel('x (m)');
ylabel('p (Pa)');
title('Pressure vs x (Cases A–D)');
xline(0,'--');
legend({sol.name}, 'Location','best');

function dM2dx = shapiro_dM2dx_branch(M2, k, dlnA_dx, dlnT0_dx, S, d2lnA_dx2, d2lnT0_dx2, dSdx)

G = M2 * (1 + (k-1)/2 * M2) * ( ...
    -2*dlnA_dx ...
    + (1 + k*M2)*dlnT0_dx ...
    + k*M2*S );

denom = (1 - M2);

if abs(denom) > 1e-6
    dM2dx = G/denom;
    return
end

Phi = (k*(k+1)/2)*dlnT0_dx + (k*(k+1)/2)*S;

Psi = -(k+1)*d2lnA_dx2 ...
    + ((k+1)^2/2)*d2lnT0_dx2 ...
    + (k*(k+1)/2)*dSdx;

disc = (Phi/2)^2 - Psi;
if disc < 0
    disc = 0;
end

root1 = -Phi/2 + sqrt(disc);
root2 = -Phi/2 - sqrt(disc);

epsm = 1e-7;
M2p = 1 + epsm;
Gp = M2p * (1 + (k-1)/2 * M2p) * ( ...
    -2*dlnA_dx ...
    + (1 + k*M2p)*dlnT0_dx ...
    + k*M2p*S );
dlim = Gp/(1 - M2p);

if abs(root1 - dlim) <= abs(root2 - dlim)
    dM2dx = root1;
else
    dM2dx = root2;
end

end