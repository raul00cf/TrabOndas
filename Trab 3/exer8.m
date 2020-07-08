Ez = zeros(2, 101, 101);
Hy = zeros(2, 101, 101);
Hx = zeros(2, 101, 101);
Ez1 = zeros(2, 101, 101);
Hy1 = zeros(2, 101, 101);
Hx1 = zeros(2, 101, 101);
Ez2 = zeros(2, 101, 101);
Hy2 = zeros(2, 101, 101);
Hx2 = zeros(2, 101, 101);
Ez3 = zeros(2, 101, 101);
Hy3 = zeros(2, 101, 101);
Hx3 = zeros(2, 101, 101);

mio = 4e-7 * pi;
eo = 8.854e-12;

delt = 0;
delt1 = 1e-4;
delt2 = 1e-3;
delt3 = 1e-2;
deltstar = 0;

mi = 10;
delta = 3.5;

c = 1 / sqrt(mio * eo);

dx = 1;
dy = dx;
dt = dx / (c * sqrt(2));

x = 0:dx:100;

us = cat(2, exp((-1 / 2) * ((x - mi) / delta).^2) ./ (delta * sqrt( 2 * pi)), zeros(1, 10000));

us = us / max(us);
Ez(1, 51, 51) = us(1);
Ez1(1, 51, 51) = us(1);
Ez2(1, 51, 51) = us(1);
Ez3(1, 51, 51) = us(1);

n = 2;

Ca = (1 - (delt * dt) / (2 * eo)) / (1 + (delt * dt) / (2 * eo));
Cb = (dt / (eo * dx)) / (1 + (delt * dt) / (2 * eo));

Ca1 = (1 - (delt1 * dt) / (2 * eo)) / (1 + (delt1 * dt) / (2 * eo));
Cb1 = (dt / (eo * dx)) / (1 + (delt1 * dt) / (2 * eo));

Ca2 = (1 - (delt2 * dt) / (2 * eo)) / (1 + (delt2 * dt) / (2 * eo));
Cb2 = (dt / (eo * dx)) / (1 + (delt2 * dt) / (2 * eo));

Ca3 = (1 - (delt3 * dt) / (2 * eo)) / (1 + (delt3 * dt) / (2 * eo));
Cb3 = (dt / (eo * dx)) / (1 + (delt3 * dt) / (2 * eo));

Da = (1 - (deltstar * dt) / (2 * mio)) / (1 + (deltstar * dt) / (2 * mio));
Db = (dt / (mio * dx)) / (1 + (deltstar * dt) / (2 * mio));

while 1
    
    for i=1:101
        for j=1:101
            if (i ~= 101)
                Hy(n, i, j) = Da * Hy(n - 1, i, j) + Db * (Ez(n - 1, i + 1, j) - Ez(n - 1, i, j));
                Hy1(n, i, j) = Da * Hy1(n - 1, i, j) + Db * (Ez1(n - 1, i + 1, j) - Ez1(n - 1, i, j));
                Hy2(n, i, j) = Da * Hy2(n - 1, i, j) + Db * (Ez2(n - 1, i + 1, j) - Ez2(n - 1, i, j));
                Hy3(n, i, j) = Da * Hy3(n - 1, i, j) + Db * (Ez3(n - 1, i + 1, j) - Ez3(n - 1, i, j));
            else
                Hy(n, i, j) = Hy(n, i - 1, j);
                Hy1(n, i, j) = Hy1(n, i - 1, j);
                Hy2(n, i, j) = Hy2(n, i - 1, j);
                Hy3(n, i, j) = Hy3(n, i - 1, j);
            end
        end
    end
    
    for i=1:101
        for j=1:101
            if (j ~= 101)
                Hx(n, i, j) = Da * Hx(n - 1, i, j) + Db * (Ez(n - 1, i, j) - Ez(n - 1, i, j + 1));
                Hx1(n, i, j) = Da * Hx1(n - 1, i, j) + Db * (Ez1(n - 1, i, j) - Ez1(n - 1, i, j + 1));
                Hx2(n, i, j) = Da * Hx2(n - 1, i, j) + Db * (Ez2(n - 1, i, j) - Ez2(n - 1, i, j + 1));
                Hx3(n, i, j) = Da * Hx3(n - 1, i, j) + Db * (Ez3(n - 1, i, j) - Ez3(n - 1, i, j + 1));
            else
                Hx(n, i, j) = Hx(n, i, j - 1);
                Hx1(n, i, j) = Hx1(n, i, j - 1);
                Hx2(n, i, j) = Hx2(n, i, j - 1);
                Hx3(n, i, j) = Hx3(n, i, j - 1);
            end
        end
    end
    
    for i=1:101
       for j=1:101
          if (i == 1 || j == 1 || i == 101 || j == 101)
              Ez(n, i, j) = 0;
              Ez1(n, i, j) = 0;
              Ez2(n, i, j) = 0;
              Ez3(n, i, j) = 0;
          else
            Ez(n, i, j) = Ca * Ez(n - 1, i, j) + Cb * (Hy(n, i, j) - Hy(n, i - 1, j) + Hx(n, i, j - 1) - Hx(n, i, j));
            Ez1(n, i, j) = Ca1 * Ez1(n - 1, i, j) + Cb1 * (Hy1(n, i, j) - Hy1(n, i - 1, j) + Hx1(n, i, j - 1) - Hx1(n, i, j));
            Ez2(n, i, j) = Ca2 * Ez2(n - 1, i, j) + Cb2 * (Hy2(n, i, j) - Hy2(n, i - 1, j) + Hx2(n, i, j - 1) - Hx2(n, i, j));
            Ez3(n, i, j) = Ca3 * Ez3(n - 1, i, j) + Cb3 * (Hy3(n, i, j) - Hy3(n, i - 1, j) + Hx3(n, i, j - 1) - Hx3(n, i, j));
          end
       end
    end
    
    Ez(n, 51, 51) = us(n);
    Ez1(n, 51, 51) = us(n);
    Ez2(n, 51, 51) = us(n);
    Ez3(n, 51, 51) = us(n);
   
    if (n == 100)
        break;
    end
    
    n = n + 1;
end

ax1 = subplot(3, 1, 1);
ax2 = subplot(3, 1, 2);
ax3 = subplot(3, 1, 3);

for n=1:100
    s1 = surf(ax1, x, x, reshape(Ez3(n, :, :), 101, 101));
    s2 = surf(ax2, x, x, reshape(Hx3(n, :, :), 101, 101));
    s3 = surf(ax3, x, x, reshape(Hy3(n, :, :), 101, 101));
    
    xlabel(ax1, 'Grid i coordinate');
    ylabel(ax1, 'Grid j coordinate');
    zlabel(ax1, 'Ez');
    xlabel(ax2, 'Grid i coordinate');
    ylabel(ax2, 'Grid j coordinate');
    zlabel(ax2, 'Hx');
    xlabel(ax3, 'Grid i coordinate');
    ylabel(ax3, 'Grid j coordinate');
    zlabel(ax3, 'Hy');
    
    axis(ax1, [0 100 0 100 -.5 1])
    axis(ax2, [0 100 0 100 -1e-2 1e-2])
    axis(ax3, [0 100 0 100 -1e-2 1e-2])
    
    zticks(ax2, [-1e-2 -5e-3 0 5e-3 1e-2])
    zticks(ax3, [-1e-2 -5e-3 0 5e-3 1e-2])
    
    s1.EdgeColor = 'none';
    s1.FaceColor = '[0.3010 0.7450 0.9330]';
    s2.EdgeColor = 'none';
    s2.FaceColor = '[0.3010 0.7450 0.9330]';
    s3.EdgeColor = 'none';
    s3.FaceColor = '[0.3010 0.7450 0.9330]';
    
    light(ax1);
    light(ax2);
    light(ax3);
    
    pause(.01)
end

pause(1);

ax = zeros(1, 12);

for k = 1:12
    ax(k) = subplot(4, 3, k);
end

plot(ax(1), x, Ez(30, :, 51))
plot(ax(2), x, Ez(50, :, 51))
plot(ax(3), x, Ez(70, :, 51))

plot(ax(4), x, Ez1(30, :, 51))
plot(ax(5), x, Ez1(50, :, 51))
plot(ax(6), x, Ez1(70, :, 51))

plot(ax(7), x, Ez2(30, :, 51))
plot(ax(8), x, Ez2(50, :, 51))
plot(ax(9), x, Ez2(70, :, 51))

plot(ax(10), x, Ez3(30, :, 51))
plot(ax(11), x, Ez3(50, :, 51))
plot(ax(12), x, Ez3(70, :, 51))

for k = 1:12
    ylim(ax(k), [-.1 .3])
    xlabel(ax(k), 'Grid i coordinate')
    ylabel(ax(k), 'Ez')
end

title(ax(1), 'n = 30 j = 50 \sigma = 0')
title(ax(2), 'n = 50 j = 50 \sigma = 0')
title(ax(3), 'n = 70 j = 50 \sigma = 0')
title(ax(4), 'n = 30 j = 50 \sigma = 10^{-4}')
title(ax(5), 'n = 50 j = 50 \sigma = 10^{-4}')
title(ax(6), 'n = 70 j = 50 \sigma = 10^{-4}')
title(ax(7), 'n = 30 j = 50 \sigma = 10^{-3}')
title(ax(8), 'n = 50 j = 50 \sigma = 10^{-3}')
title(ax(9), 'n = 70 j = 50 \sigma = 10^{-3}')
title(ax(10), 'n = 30 j = 50 \sigma = 10^{-2}')
title(ax(11), 'n = 50 j = 50 \sigma = 10^{-2}')
title(ax(12), 'n = 70 j = 50 \sigma = 10^{-2}')
