% Master TECI
% Técnicas numéricas
% Práctica 3. Derivación

% Ejercicio práctica 3

% Datos de la función a derivar y calculo del gradiente y hessianas exactos
clear all
close all
clc
x = -5 : 1 : 5;
y = -5 : 1 : 5;
z = -5 : 1 : 5;
[xgrid, ygrid, zgrid] = meshgrid(y, z, x);
for i = 1 : length(x)
    for j = 1 : length(y)
        for k = 1 : length(z)
            i;
            j;
            k;
            c(k, j, i) = func2([xgrid(k, j, i), ygrid(k, j, i), zgrid(k, j, i)]);
            grex = func3g([xgrid(k, j, i), ygrid(k, j, i), zgrid(k, j, i)]);
            gradx(k, j, i) = grex(1);
            grady(k, j, i) = grex(2);
            gradz(k, j, i) = grex(3);
        end
    end
end
%figure(1)
%hold on
%surface(xgrid, ygrid, zgrid, c)
%contour(xgrid, ygrid, zgrind, c)
%view([45 45])
%quiver(x, y, gradx, grady)
%title('Gradiente exacto')

% Cálculo del gradiente mediante una aproximaciónde Taylor centrada
eps = 1e-5
for i = 1 : length(x)
    for j = 1 : length(y)
        for k = 1 : length(z)
            zpx = func3([xgrid(k, j, i) + eps, ygrid(k, j, i), zgrid(k, j, i)]);
            zmx = func3([xgrid(k, j, i) - eps, ygrid(k, j, i), zgrid(k, j, i)]);
            gradtx(k, j, i) = (zpx - zmx) / (2 * eps);
            zpy = func3([xgrid(k, j, i), ygrid(k, j, i) + eps, zgrid(k, j, i)]);
            zmy = func3([xgrid(k, j, i), ygrid(k, j, i) - eps, zgrid(k, j, i)]);
            gradty(k, j, i) = (zpy - zmy) / (2 * eps);
            zpz = func3([xgrid(k, j, i), ygrid(k, j, i), zgrid(k, j, i) + eps]);
            zmz = func3([xgrid(k, j, i), ygrid(k, j, i), zgrid(k, j, i) - eps]);
            gradtz(k, j, i) = (zpz - zmz) / (2 * eps);
        end
    end
end
%figure(2)
%hold on
%surface(xgrid, ygrid, z)
%contour(xgrid, ygrid, z)
%view([45 45])
%quiver(x, y, gradtx, gradty)
%title('Gradiente aproximado')
disp('Errores en la aproximación del gradiente')
gradx(1, 1, 1)

[x, y, z] = getGrad3D(xgrid, ygrid, zgrid, gradx, grady, gradz, 0, 0, 0)
[xt, yt, zt] = getGrad3D(xgrid, ygrid, zgrid, gradtx, gradty, gradtz, 0, 0, 0)