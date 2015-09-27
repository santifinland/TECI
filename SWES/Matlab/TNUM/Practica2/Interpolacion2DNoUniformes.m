% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación

% Interpolación 2D de datos no uniformes
clear all
close all
clc

% Creación de datos
x = [1 5 15 -9 -10 8 7 -8];
y = [-5 3 8 -3 10 -10 5 2];
z = [1 5 3 7 10 4 8 9];

% Plot de datos originales
k = 1;
figure(k)
clc
hold on
plot3(x, y, z, 'ok')
view([45 45])
axis('tight')
title('Original data')

% Puntos donde vamos a interpolar
xi = min(x) : ((max(x) - min(x)) / 99) : max(x)
yi = min(y) : ((max(y) - min(y)) / 99) : max(y)
[xxi, yyi] = meshgrid(yi, xi);

% Interpolación nearest
zzi = griddata(x, y, z, xxi, yyi, 'nearest');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi, 'Edgecolor', 'none')
title('Nearest interpolation')
view([45 45])
axis('tight')
plot3(x, y, z, 'ok')

% Interpolación lineal
zzi = griddata(x, y, z, xxi, yyi, 'linear');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi, 'Edgecolor', 'none')
title('Nearest interpolation')
view([45 45])
axis('tight')
plot3(x, y, z, 'ok')

% Interpolación cubic
zzi = griddata(x, y, z, xxi, yyi, 'cubic');
k = k + 1;
figure(k)
clf
hold on
surface(xxi, yyi, zzi, 'Edgecolor', 'none')
title('Cubic interpolation')
view([45 45])
axis('tight')
plot3(x, y, z, 'ok')




