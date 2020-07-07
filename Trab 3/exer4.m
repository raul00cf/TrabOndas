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
            Hy(n, i) = 0;
        end
    end
    
    for i=2:200
       Ez(n, i) = Ca * Ez(n - 1, i) + Cb * (Hy(n, i) - Hy(n, i - 1));
    end
    
    Ez(n, 1) = us(n);
    
    plot(ax1, x, Ez(n, :))
    axis([1 200 -1.2 1.2])
    
    plot(ax2, x, Hy(n, :))
    axis(ax1, [1 200 -0.2 2.2])
    axis(ax2, [1 200 -.005 .005])
    
    pause(.01);
    
    n = n + 1;
    
    if (n == 400)
        break;
    end
end