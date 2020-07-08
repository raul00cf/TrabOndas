S = 1;
S1 = 1.075;

delta = 3.5;
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
        if (i == 90)
            u(n + 1, i) = (S1^2 * (u(n, i + 1) - 2 * u(n, i) + u(n, i - 1))) + 2 * u(n, i) - u(n - 1, i);
        else
            u(n + 1, i) = (S^2 * (u(n, i + 1) - 2 * u(n, i) + u(n, i - 1))) + 2 * u(n, i) - u(n - 1, i);
        end
    end
  
    %{
    if (n == 200)
        plot(x, u(200, :), 'k:', x, u(190, :), 'k-', [73 77], [.5 .5], 'k:', [73 77], [.7 .7], 'k-')
        text(77.5, .51, 'n = 220')
        text(77.5, .71, 'n = 190')
    %}
        
    if (n == 277)
        plot(x, u(277, :), 'k:', x, u(267, :), 'k-', [73 77], [.5 .5], 'k:', [73 77], [.7 .7], 'k-')
        text(77.5, .51, 'n = 277')
        text(77.5, .71, 'n = 267')
        
        xlabel('Grid i coordinate')
        ylabel('Wavefunction u(i)')
        xticks([70 75 80 85 90 95 100 105 110])
        yticks([-1 -0.5 0 0.5 1])

        axis([70 110 -1 1])
        pause(1);
        break;
    else
        plot(x, u(n, :), 'k')
        xlabel('Grid i coordinate')
        ylabel('Wavefunction u(i)')
        xticks([0 20 40 60 80 100 120 140 160 180 200, 220])
        yticks([-1 -0.5 0 0.5 1])

        axis([0 220 -1 1])
        pause(.01);
    end

    n = n + 1;
    
end

