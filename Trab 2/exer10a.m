S = 1.0005;

delta = 14;
mi = 60;

dx = 1;

x = 1:dx:220;

u = zeros(1, (219 / dx) + 1);

us = cat(2, exp((-1 / 2) * ((x - mi) / delta).^2) ./ (delta * sqrt( 2 * pi)), zeros(1, 10000));

us = us / max(us);

u(1, 1) = us(1);

n = 2;

while 1
    u(n, 1) = us(n);
    
    for i = 2:(219 / dx)
        u(n + 1, i) = (S^2 * (u(n, i + 1) - 2 * u(n, i) + u(n, i - 1))) + 2 * u(n, i) - u(n - 1, i);
    end
    
    if (n == 220)
        
        plot(x, u(200, :), 'k-', x, u(210, :), 'k:', x, u(220, :), 'k--', [30 50], [.65 .65], 'k--', [30 50], [.8 .8], 'k:', [30 50], [.95 .95], 'k-')
        
        text(52, 0.96, 'n = 200')
        text(52, 0.81, 'n = 210')
        text(52, 0.66, 'n = 220')
        
        xlabel('Grid i coordinate')
        ylabel('Wavefunction u(i)')
        xticks([0 50 100 150 200])
        
    
        axis([0 220 -0.2 1.2])
        pause(1);
        break;
    else
        plot(x, u(n, :), 'k')
        xlabel('Grid i coordinate')
        ylabel('Wavefunction u(i)')
        xticks([0 50 100 150 200])

        axis([0 220 -0.2 1.2])
        pause(.01);
    end

    n = n + 1;
    
end

