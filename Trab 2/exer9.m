S = 1;
S1 = .25;


mi = 60;
delta = 14;

dx = 1;

x = 0:dx:200;

u = zeros(1, (200 / dx) + 1);

us = cat(2, exp((-1 / 2) * ((x - mi) / delta).^2) ./ (delta * sqrt( 2 * pi)), zeros(1, 10000));

us = us / max(us);

u(1, 1) = us(1);

n = 2;

xLinha = [139.99 140.01];
yLinha = [-1 1];


while 1
    u(n, 1) = us(n);
    
    for i = 2:(140 / dx) + 1
        u(n + 1, i) = (S^2 * (u(n, i + 1) - 2 *u(n, i) + u(n, i - 1))) + 2 * u(n, i) - u(n - 1, i);
    end
    for i = (140 / dx) + 2:(200 / dx)
        u(n + 1, i) = (S1^2 * (u(n, i + 1) - 2 *u(n, i) + u(n, i - 1))) + 2 * u(n, i) - u(n - 1, i);
    end
    
    plot(x, u(n, :), 'black',  xLinha, yLinha, 'black--')
    text(110, -0.6, {'Free', 'Space', 'S=1.0'});
    text(160, -0.6, {'Material', 'half-space', 'S=0.25'});
    xlabel('Grid i coordinate')
    ylabel('Wavefunction u(i)')
    xticks([0 50 100 150 200])
    
    axis([0 200 -0.8 0.6])

    n = n + 1;

    if (n == 260)
        pause(1);
        break;
    else
        pause(.01);
    end
end
