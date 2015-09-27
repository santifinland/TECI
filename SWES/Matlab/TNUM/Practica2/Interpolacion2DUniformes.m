% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación

% Interpolación 2D de datos uniformes
clear all
close all
clc

% Creación de datos
x = -10 : 5 : 10;
y = -20 : 5 : 20;
[xx, yy] = meshgrid(y, x);
for ii = 1 : length(x)
    for jj = 1 : length(y)
        zz(ii, jj) = cos(x(ii)) + sin(y(jj))
    end
end

% Plot de datos originales
k = 1;
figure(k)
clf
hold on
surface(xx, yy, zz)
view([45 45])
axis('tight')
plot3(xx, yy, zz, 'or')
title('Original data')

% Puntos donde vamos a interpolar
xi = -10 : .5 : 10;
yi = -20 : .5 : 20;
[xxi, yyi] = meshgrid(yi, xi);

% Interpolación nearest
zzi = interp2(xx, yy, zz, xxi, yyi, 'nearest');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi)
view([45 45])
axis('tight')
plot3(xx, yy, zz, 'oy')
title('Nearest interpolation')

% Interpolación lineal
zzi = interp2(xx, yy, zz, xxi, yyi, 'linear');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi)
view([45 45])
axis('tight')
plot3(xx, yy, zz, 'oy')
title('Linear interpolation')

% Interpolación de Hermite
zzi = interp2(xx, yy, zz, xxi, yyi, 'cubic');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi)
view([45 45])
axis('tight')
plot3(xx, yy, zz, 'oy')
title('Hermit interpolation')

% Interpolación Spline
zzi = interp2(xx, yy, zz, xxi, yyi, 'spline');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi)
view([45 45])
axis('tight')
plot3(xx, yy, zz, 'oy')
title('Spline interpolation')




