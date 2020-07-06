S = 1;
S1 = .99;

dx = 1;
dx1 = dx / S1;

x = 0:dx:200;
x1 = 0:dx1:200;

u = zeros(1, (200 / dx) + 1);
u1 = zeros(1, (200 / dx) + 1);

us = cat(2, ones(1, 40 / dx), zeros(1, (160 / dx) + 1));
us1 = cat(2, ones(1, 40 / dx), zeros(1, (160 / dx) + 1));

u(1, 1) = us(1);
u1(1, 1) = us1(1);

n = 2;
n1 = 2;

while 1
    u(n, 1) = us(n);
    u1(n1, 1) = us1(n1);
    for i = 2:(200 / dx)
        u(n + 1, i) = (S^2 * (u(n, i + 1) - 2 *u(n, i) + u(n, i - 1))) + 2 * u(n, i) - u(n - 1, i);
    end
    for i = 2:(200 / dx1)
        u1(n1 + 1, i) = (S1^2 * (u1(n1, i + 1) - 2 *u1(n1, i) + u1(n1, i - 1))) + 2 * u1(n1, i) - u1(n1 - 1, i);
    end
    
    plot(x, u(n, :), 'r:', x / S1, u1(n1, :), 'black-')
    xlabel('Grid i coordinate')
    ylabel('Wavefunction u(i)')
    xticks([0 50 100 150 200])
    legend({'S = 1.0', 'S = 0.99'}, 'Location', 'northwest')
    
    axis([0 200 -0.2 1.4])
    
    if (n == 160 / dx)
        if (n1 >= (160 / dx) * S1)
            pause(1);
            break;
        else
            n1 = n1 - 1;
        end
    else
       n = n + 1;
       n1 = n1 + 1; 
    end
    pause(.01);
end
