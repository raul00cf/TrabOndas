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
Ez(1, 51, 51) = us(1);

n = 2;

Ca = (1 - (delt * dt) / (2 * eo)) / (1 + (delt * dt) / (2 * eo));
Cb = (dt / (eo * dx)) / (1 + (delt * dt) / (2 * eo));

Da = (1 - (deltstar * dt) / (2 * mio)) / (1 + (deltstar * dt) / (2 * mio));
Db = (dt / (mio * dx)) / (1 + (deltstar * dt) / (2 * mio));

ax1 = subplot(3, 3, 1);
ax2 = subplot(3, 3, 2);
ax3 = subplot(3, 3, 3);
ax4 = subplot(3, 3, 4);
ax5 = subplot(3, 3, 5);
ax6 = subplot(3, 3, 6);
ax7 = subplot(3, 3, 7);
ax8 = subplot(3, 3, 8);
ax9 = subplot(3, 3, 9);

while 1
    
    for i=1:101
        for j=1:101
            if (i ~= 101)
                Hy(n, i, j) = Da * Hy(n - 1, i, j) + Db * (Ez(n - 1, i + 1, j) - Ez(n - 1, i, j));
                if (i == 2)
                    Hy(n, i - 1, j) = Hy(n, i, j);
                end
            else
                Hy(n, i, j) = Hy(n, i - 1, j);
            end
        end
    end
    
    for i=1:101
        for j=1:101
            if (j ~= 101)
                Hx(n, i, j) = Da * Hx(n - 1, i, j) + Db * (Ez(n - 1, i, j) - Ez(n - 1, i, j + 1));
                if (j == 2)
                    Hx(n, i, j + 1) = Hx(n, i, j);
                end
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
    
    Ez(n, 51, 51) = us(n);
    
    s1 = surf(ax1, x, x, reshape(Ez(n, :, :), 101, 101));
    s2 = surf(ax2, x, x, reshape(Hx(n, :, :), 101, 101));
    s3 = surf(ax3, x, x, reshape(Hy(n, :, :), 101, 101));
    
    plot(ax4, x, reshape(Ez(n, 51, :), 1, 101));
    plot(ax5, x, reshape(Hx(n, 51, :), 1, 101));
    plot(ax6, x, reshape(Hy(n, 51, :), 1, 101));
    
    plot(ax7, x, Ez(n, :, 51));
    plot(ax8, x, Hx(n, :, 51));
    plot(ax9, x, Hy(n, :, 51));
    
    axis(ax1, [0 100 0 100 -.5 1])
    axis(ax2, [0 100 0 100 -6e-3 6e-3])
    axis(ax3, [0 100 0 100 -6e-3 6e-3])
    axis(ax4, [0 100 -.5 1])
    axis(ax5, [0 100 -6e-3 6e-3])
    axis(ax6, [0 100 -6e-3 6e-3])
    axis(ax7, [0 100 -.5 1])
    axis(ax8, [0 100 -6e-3 6e-3])
    axis(ax9, [0 100 -6e-3 6e-3])
    
    s1.EdgeColor = 'none';
    s1.FaceColor = 'interp';
    s2.EdgeColor = 'none';
    s2.FaceColor = 'interp';
    s3.EdgeColor = 'none';
    s3.FaceColor = 'interp';
    
    pause(.01)

    n = n + 1;
    
    if (n == 100)
        break;
    end
end