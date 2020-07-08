S = 1/sqrt(2);
c = 3 * 10^8;
Ntrans = (2 * pi * S) / acos(1 - 2 * S^2);
Nreal = Ntrans:0.001:10;
Vp = ((2 * pi) ./ (Nreal .* acos(1 + 4 * (cos(pi ./ Nreal) - 1)))) * c;
Nim = 1:0.001:Ntrans - 0.001;
vPim = 2 * c ./ Nim;
v = cat(2, vPim, Vp);
N = cat(2, Nim, Nreal);
Phiim = 1 + (1 / S)^2*(cos((2 * pi * S) ./ Nim) - 1);
alpha = - Phiim - sqrt(Phiim.^2 - 1);
alphaln = log(alpha);
alp = cat(2, -alphaln, zeros(1, size(Nreal, 2)) - 2);
[AX, H1, H2] = plotyy(N, real(alp), N, real(v/c));

text(5.5, 3.5, 'Numerical phase velocity');
text(3.25, 0.9, 'Attenuation constant');

set(get(AX(1), 'Ylabel'), 'String', 'Attenuation Constante (nepers/grid cell)', 'color', 'black')
set(get(AX(2), 'Ylabel'), 'String', 'Numerical Phase Velocity (normalized to c)', 'color', 'black')

set(AX(1), 'Ylim', [0, 6], 'YTick', [0 1 2 3 4 5 6], 'ycolor', 'black')
set(AX(2), 'Ylim', [0, 2], 'YTick', [0 0.5 1 1.5 2], 'ycolor', 'black')

set(H1, 'LineStyle', '-.', 'color', 'black')
set(H2, 'LineStyle', '-', 'color', 'black')

xlabel('Grid Sampling Density (points per free-space wavelength)');