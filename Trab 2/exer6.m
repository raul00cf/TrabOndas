S = 1/sqrt(2);
Ntrans = (2 * pi * S) / acos(1 - 2 * S^2);
Nreal = Ntrans:0.001:80;
Vp = ((2 * pi) ./ (Nreal .* acos(1 + 4 * (cos(pi ./ Nreal) - 1))));
error = 1 - Vp;

semilogy(Nreal, error * 100, 'color', 'black')

yticks([0.01 0.1 1 10 100]);
yticklabels({'0.01', '0.1', '1', '10', '100'});

xlabel('Grid Sampling Density (points per free-space wavelength)');
ylabel('Phase Velocity Error (%)');