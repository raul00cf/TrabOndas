Ez = zeros(2, 200);
Ez1 = zeros(2, 200);
Hy = zeros(2, 200);
Hy1 = zeros(2, 200);

mio = 4e-7 * pi;
eo = 8.854e-12;

delt = 0;
deltstar = 0;

mi = 60;
delta = 3.5;

c = 1 / sqrt(mio * eo);

dx = 1;
dt = dx / c;
dt1 = 1.01 * dx / c;

x = 1:dx:200;

us = cat(2, exp((-1 / 2) * ((x - mi) / delta).^2) ./ (delta * sqrt( 2 * pi)), zeros(1, 10000));

us = us / max(us);
Ez(1, 1) = us(1);

n = 2;

Ca = (1 - (delt * dt) / (2 * eo)) / (1 + (delt * dt) / (2 * eo));
Cb = (dt / (eo * dx)) / (1 + (delt * dt) / (2 * eo));

Da = (1 - (deltstar * dt) / (2 * mio)) / (1 + (deltstar * dt) / (2 * mio));
Db = (dt / (mio * dx)) / (1 + (deltstar * dt) / (2 * mio));

Ca1 = (1 - (delt * dt1) / (2 * eo)) / (1 + (delt * dt1) / (2 * eo));
Cb1 = (dt1 / (eo * dx)) / (1 + (delt * dt1) / (2 * eo));

Da1 = (1 - (deltstar * dt1) / (2 * mio)) / (1 + (deltstar * dt1) / (2 * mio));
Db1 = (dt1 / (mio * dx)) / (1 + (deltstar * dt1) / (2 * mio));

ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);

while 1
    
    for i=1:200
        if (i ~= 200)
            Hy(n, i) = Da * Hy(n - 1, i) + Db * (Ez(n - 1, i + 1) - Ez(n - 1, i));
            Hy1(n, i) = Da1 * Hy1(n - 1, i) + Db1 * (Ez1(n - 1, i + 1) - Ez1(n - 1, i));
        else
            Hy(n, i) = Hy(n, i - 1);
            Hy1(n, i) = Hy1(n, i - 1);
        end
    end
    
    for i=2:200
       Ez(n, i) = Ca * Ez(n - 1, i) + Cb * (Hy(n, i) - Hy(n, i - 1));
       Ez1(n, i) = Ca1 * Ez1(n - 1, i) + Cb1 * (Hy1(n, i) - Hy1(n, i - 1));
    end
    
    Ez(n, 200) = 0;
    Ez1(n, 200) = 0;
    Ez(n, 1) = us(n);
    Ez1(n, 1) = us(n);
    
    plot(ax1, x, Ez(n, :), 'b-', x, Ez1(n, :), 'r--', [10 30], [-.9 -.9], 'r--', [10 30], [-.5 -.5], 'b-')
    
    plot(ax2, x, Hy(n, :), 'b-', x, Hy1(n, :), 'r--', [10 30], [-.007 -.007], 'r--', [10 30], [-.005 -.005], 'b-')
    
    text(ax1, 31, -.49, 'dt = dx/c')
    text(ax1, 31, -.89, 'dt = 1.01dx/c')
    text(ax2, 31, -.0049, 'dt = dx/c')
    text(ax2, 31, -.0069, 'dt = 1.01dx/c')
    
    xlabel(ax1, 'Grid i coordinate');
    ylabel(ax1, 'Ez');
    xlabel(ax2, 'Grid i coordinate')
    ylabel(ax2, 'Hy');
    axis(ax1, [1 200 -1.2 1.2]);
    axis(ax2, [1 200 -.008 .002])
    
    pause(.01);
    
    if (n == 200)
        pause(1);
        break;
    end
    
    n = n + 1;
end

ax1 = subplot(2, 2, 1);
ax2 = subplot(2, 2, 2);
ax3 = subplot(2, 2, 3);
ax4 = subplot(2, 2, 4);

plot(ax1, x, Ez(180, :), 'b-', x, Ez1(180, :), 'r--', [10 30], [-.9 -.9], 'r--', [10 30], [-.5 -.5], 'b-')
plot(ax2, x, Hy(180, :), 'b-', x, Hy1(180, :), 'r--', [10 30], [-.007 -.007], 'r--', [10 30], [-.005 -.005], 'b-')
plot(ax3, x, Ez(200, :), 'b-', x, Ez1(200, :), 'r--', [10 30], [-.9 -.9], 'r--', [10 30], [-.5 -.5], 'b-')
plot(ax4, x, Hy(200, :), 'b-', x, Hy1(200, :), 'r--', [10 30], [-.007 -.007], 'r--', [10 30], [-.005 -.005], 'b-')

text(ax1, 31, -.49, 'dt = dx/c')
text(ax1, 31, -.89, 'dt = 1.01dx/c')
text(ax2, 31, -.0049, 'dt = dx/c')
text(ax2, 31, -.0069, 'dt = 1.01dx/c')
text(ax3, 31, -.49, 'dt = dx/c')
text(ax3, 31, -.89, 'dt = 1.01dx/c')
text(ax4, 31, -.0049, 'dt = dx/c')
text(ax4, 31, -.0069, 'dt = 1.01dx/c')

axis(ax1, [1 200 -1.2 1.2])
axis(ax2, [1 200 -.008 .002])
axis(ax3, [1 200 -1.2 1.2])
axis(ax4, [1 200 -.008 .002])

title(ax1, 'n = 180')
title(ax2, 'n = 180')
title(ax3, 'n = 200')
title(ax4, 'n = 200')

xlabel(ax1, 'Grid i coordinate');
ylabel(ax1, 'Ez');
xlabel(ax2, 'Grid i coordinate')
ylabel(ax2, 'Hy');
xlabel(ax3, 'Grid i coordinate');
ylabel(ax3, 'Ez');
xlabel(ax4, 'Grid i coordinate')
ylabel(ax4, 'Hy');