Ez = zeros(2, 200);
Hy = zeros(2, 200);

mio = 4e-7 * pi;
eo = 8.854e-12;

delt = 0;
deltstar = 0;

mi = 60;
delta = 14;

c = 1 / sqrt(mio * eo);

dx = 1;
dt = dx / c;

x = 1:dx:200;

us = cat(2, exp((-1 / 2) * ((x - mi) / delta).^2) ./ (delta * sqrt( 2 * pi)), zeros(1, 10000));

us = us / max(us);
Ez(1, 1) = us(1);

n = 2;

Ca = (1 - (delt * dt) / (2 * eo)) / (1 + (delt * dt) / (2 * eo));
Cb = (dt / (eo * dx)) / (1 + (delt * dt) / (2 * eo));

Da = (1 - (deltstar * dt) / (2 * mio)) / (1 + (deltstar * dt) / (2 * mio));
Db = (dt / (mio * dx)) / (1 + (deltstar * dt) / (2 * mio));

ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);

while 1
    
    for i=1:200
        if (i ~= 200)
            Hy(n, i) = Da * Hy(n - 1, i) + Db * (Ez(n - 1, i + 1) - Ez(n - 1, i));
        else
            Hy(n, i) = Hy(n, i - 1);
        end
    end
    
    for i=2:200
       Ez(n, i) = Ca * Ez(n - 1, i) + Cb * (Hy(n, i) - Hy(n, i - 1));
    end
    
    Ez(n, 200) = 0;
   
    Ez(n, 1) = us(n);
    
    plot(ax1, x, Ez(n, :))
    
    plot(ax2, x, Hy(n, :))
    
    xlabel(ax1, 'Grid i coordinate');
    ylabel(ax1, 'Ez');
    xlabel(ax2, 'Grid i coordinate')
    ylabel(ax2, 'Hy');
    axis(ax1, [1 200 -1.2 1.2])
    axis(ax2, [1 200 -.008 .002])
    
    pause(.01);
    
    n = n + 1;
    
    if (n == 400)
        pause(1);
        break;
    end
end

ax1 = subplot(3, 2, 1);
ax2 = subplot(3, 2, 2);
ax3 = subplot(3, 2, 3);
ax4 = subplot(3, 2, 4);
ax5 = subplot(3, 2, 5);
ax6 = subplot(3, 2, 6);

plot(ax1, x, Ez(210, :))
plot(ax2, x, Hy(210, :))
plot(ax3, x, Ez(260, :))
plot(ax4, x, Hy(260, :))
plot(ax5, x, Ez(310, :))
plot(ax6, x, Hy(310, :))

axis(ax1, [1 200 -1.2 1.2])
axis(ax2, [1 200 -.008 .002])
axis(ax3, [1 200 -1.2 1.2])
axis(ax4, [1 200 -.008 .002])
axis(ax5, [1 200 -1.2 1.2])
axis(ax6, [1 200 -.008 .002])

title(ax1, 'n = 210')
title(ax2, 'n = 210')
title(ax3, 'n = 260')
title(ax4, 'n = 260')
title(ax5, 'n = 310')
title(ax6, 'n = 310')

xlabel(ax1, 'Grid i coordinate');
ylabel(ax1, 'Ez');
xlabel(ax2, 'Grid i coordinate')
ylabel(ax2, 'Hy');
xlabel(ax3, 'Grid i coordinate');
ylabel(ax3, 'Ez');
xlabel(ax4, 'Grid i coordinate')
ylabel(ax4, 'Hy');
xlabel(ax5, 'Grid i coordinate');
ylabel(ax5, 'Ez');
xlabel(ax6, 'Grid i coordinate')
ylabel(ax6, 'Hy');