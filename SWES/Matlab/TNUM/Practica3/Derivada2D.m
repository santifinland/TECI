% Master TECI
% Técnicas numéricas
% Práctica 3. Derivación

% Derivación en dimensión 2

% Datos de la función a derivar y calculo del gradiente y hessianas exactos
clear all
close all
clc
x = -2 : .5 : 4;
y = 0 : .5 : 2 * pi;
[xgrid, ygrid] = meshgrid(x, y);
for i = 1 : length(x)
    for j = 1 : length(y)
        z(j, i) = func2([xgrid(j, i), ygrid(j, i)]);
        grex = func2g([xgrid(j, i), ygrid(j, i)]);
        hsex = func2h([xgrid(j, i), ygrid(j, i)]);
        gradx(j, i) = grex(1)
        grady(j, i) = grex(2);
        hessxx(j, i) = hsex(1);
        hessxy(j, i) = hsex(2);
        hessyx(j, i) = hsex(3);
        hessyy(j, i) = hsex(4);
    end
end
figure(1)
hold on
surface(xgrid, ygrid, z)
contour(xgrid, ygrid, z)
view([45 45])
quiver(x, y, gradx, grady)
title('Gradiente exacto')

% Cálculo del gradiente mediante una aproximaciónde Taylor centrada
eps = 1e-5
for i = 1 : length(x)
    for j = 1 : length(y)
        zpx = func2([xgrid(j, i) + eps, ygrid(j, i)]);
        zmx = func2([xgrid(j, i) - eps, ygrid(j, i)]);
        gradtx(j, i) = (zpx - zmx) / (2 * eps);
        zpy = func2([xgrid(j, i), ygrid(j, i) + eps]);
        zmy = func2([xgrid(j, i), ygrid(j, i) - eps]);
        gradty(j, i) = (zpy - zmy) / (2 * eps);
    end
end
figure(2)
hold on
surface(xgrid, ygrid, z)
contour(xgrid, ygrid, z)
view([45 45])
quiver(x, y, gradtx, gradty)
title('Gradiente aproximado')
disp('Errores en la aproximación del gradiente')
norm(gradx - gradtx, 2)
norm(grady - gradty, 2)

% Cálculo de la hessiana mediante una aproximación de Taylor centrada
for i = 1 : length(x)
    for j = 1 : length(y)
        zpr = func2([xgrid(j, i), ygrid(j, i)]);
        zpx = func2([xgrid(j, i) + eps, ygrid(j, i)]);
        zmx = func2([xgrid(j, i) - eps, ygrid(j, i)]);
        hstxx(j, i) = (zpx + zmx - 2 * zpr) / (eps^2);
        zpy = func2([xgrid(j, i), ygrid(j, i) + eps]);
        zmy = func2([xgrid(j, i), ygrid(j, i) - eps]);
        hstyy(j, i) = (zpy + zmy - 2 * zpr) / (eps^2);
        zpx1 = func2([xgrid(j, i) + eps, ygrid(j, i) + eps]);
        zmx1 = func2([xgrid(j, i) - eps, ygrid(j, i) + eps]);
        zpx2 = func2([xgrid(j, i) + eps, ygrid(j, i) - eps]);
        zmx2 = func2([xgrid(j, i) - eps, ygrid(j, i) - eps]);
        hstyx(j, i) = (((zpx1 - zmx1) / (2 * eps)) - ((zpx2 - zmx2) / (2 * eps))) / (2 * eps);
        hstxy(j, i) = (((zpx1 - zpx1) / (2 * eps)) - ((zmx2 - zmx2) / (2 * eps))) / (2 * eps);
    end
end

disp('Errores en al aproximación de la hessiana')
norm(hessxx - hstxx, 2)
norm(hessyy - hstyy, 2)
norm(hessxy - hstxy, 2)
norm(hessyx - hstyx, 2)

[x, y] = getGrad2D(xgrid, ygrid, gradx, grady, 0, 0)
[xt, yt] = getGrad2D(xgrid, ygrid, gradtx, gradty, 0, 0)