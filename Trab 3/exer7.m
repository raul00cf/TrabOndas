Ez = zeros(2, 101, 101);
Hy = zeros(2, 101, 101);
Hx = zeros(2, 101, 101);

mio = 4e-7 * pi;
eo = 8.854e-12;

delt = 0;
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
Ez(1, 50, 50) = us(1);

n = 2;

Ca = (1 - (delt * dt) / (2 * eo)) / (1 + (delt * dt) / (2 * eo));
Cb = (dt / (eo * dx)) / (1 + (delt * dt) / (2 * eo));

Da = (1 - (deltstar * dt) / (2 * mio)) / (1 + (deltstar * dt) / (2 * mio));
Db = (dt / (mio * dx)) / (1 + (deltstar * dt) / (2 * mio));

ax1 = subplot(3, 1, 1);
ax2 = subplot(3, 1, 2);
ax3 = subplot(3, 1, 3);

while 1
    
    for i=1:101
        for j=1:101
            if (i ~= 101)
                Hy(n, i, j) = Da * Hy(n - 1, i, j) + Db * (Ez(n - 1, i + 1, j) - Ez(n - 1, i, j));
            else
                Hy(n, i, j) = Hy(n, i - 1, j);
            end
        end
    end
    
    for i=1:101
        for j=1:101
            if (j ~= 101)
                Hx(n, i, j) = Da * Hx(n - 1, i, j) + Db * (Ez(n - 1, i, j) - Ez(n - 1, i, j + 1));
            else
                Hx(n, i, j) = Hx(n, i, j - 1);
            end
        end
    end
    
    for i=1:101
       for j=1:101
          if (i == 1 || j == 1 || i == 101 || j == 101)
              Ez(n, i, j) = 0;
          else
            Ez(n, i, j) = Ca * Ez(n - 1, i, j) + Cb * (Hy(n, i, j) - Hy(n, i - 1, j) + Hx(n, i, j - 1) - Hx(n, i, j));
          end
       end
    end
    
    Ez(n, 50, 50) = us(n);
    
    s1 = surf(ax1, x, x, reshape(Ez(n, :, :), 101, 101));
    s2 = surf(ax2, x, x, reshape(Hx(n, :, :), 101, 101));
    s3 = surf(ax3, x, x, reshape(Hy(n, :, :), 101, 101));
    
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
    axis(ax2, [0 100 0 100 -6e-3 6e-3])
    axis(ax3, [0 100 0 100 -6e-3 6e-3])
    
    zticks(ax2, [-6e-3 -3e-3 0 3e-3 6e-3])
    zticks(ax3, [-6e-3 -3e-3 0 3e-3 6e-3])
    
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

    n = n + 1;
    
    if (n == 120)
        pause(1);
        break;
    end
end

ax = zeros(1, 12);

for k = 1:12
    ax(k) = subplot(4, 3, k);
end

plot(ax(1), Ez(70, :, 50));
plot(ax(4), Ez(100, :, 50));
plot(ax(7), reshape(Ez(70, 50, :), 1, 101));
plot(ax(10), reshape(Ez(100, 50, :), 1, 101));

plot(ax(2), Hx(70, :, 50));
plot(ax(5), Hx(100, :, 50));
plot(ax(8), reshape(Hx(70, 50, :), 1, 101));
plot(ax(11), reshape(Hx(100, 50, :), 1, 101));

plot(ax(3), Hy(70, :, 50));
plot(ax(6), Hy(100, :, 50));
plot(ax(9), reshape(Hy(70, 50, :), 1, 101));
plot(ax(12), reshape(Hy(100, 50, :), 1, 101));

for k = 1:4
    axis(ax(1 + (k - 1) * 3), [0 100 -.15 .15])
    yticks(ax(1 + (k - 1) * 3), [-.15 -.1 -.05 0 .05 .1 .15])
    for j = 2:3
        axis(ax(j + (k - 1) * 3), [0 100 -6e-3 6e-3])
    end
end

title(ax(1), 'j = 50 n = 70')
title(ax(2), 'j = 50 n = 70')
title(ax(3), 'j = 50 n = 70')
title(ax(4), 'j = 50 n = 100')
title(ax(5), 'j = 50 n = 100')
title(ax(6), 'j = 50 n = 100')
title(ax(7), 'i = 50 n = 70')
title(ax(8), 'i = 50 n = 70')
title(ax(9), 'i = 50 n = 70')
title(ax(10), 'i = 50 n = 100')
title(ax(11), 'i = 50 n = 100')
title(ax(12), 'i = 50 n = 100')

xlabel(ax(1), 'Grid i coordinate');
ylabel(ax(1), 'Ez');
xlabel(ax(2), 'Grid i coordinate')
ylabel(ax(2), 'Hx');
xlabel(ax(3), 'Grid i coordinate');
ylabel(ax(3), 'Hy');
xlabel(ax(4), 'Grid i coordinate')
ylabel(ax(4), 'Ez');
xlabel(ax(5), 'Grid i coordinate');
ylabel(ax(5), 'Hx');
xlabel(ax(6), 'Grid i coordinate')
ylabel(ax(6), 'Hy');
xlabel(ax(7), 'Grid j coordinate');
ylabel(ax(7), 'Ez');
xlabel(ax(8), 'Grid j coordinate')
ylabel(ax(8), 'Hx');
xlabel(ax(9), 'Grid j coordinate');
ylabel(ax(9), 'Hy');
xlabel(ax(10), 'Grid j coordinate')
ylabel(ax(10), 'Ez');
xlabel(ax(11), 'Grid j coordinate');
ylabel(ax(11), 'Hx');
xlabel(ax(12), 'Grid j coordinate')
ylabel(ax(12), 'Hy');