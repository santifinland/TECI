% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación

% Interpolación 3D de datos uniformes
clear all
close all
clc

% Creación de datos
x = -10 : 5 : 10;
y = -20 : 5 : 20;
z = -10 : 5 : 10;
[xg, yg, zg] = meshgrid(y, x, z);
for ii = 1 : length(x)
    for jj = 1 : length(y)
        for kk = 1 : length(z)
            dat(ii, jj, kk) = x(ii)^3 + y(jj)^2 + z(kk)^2;
        end
    end
end

% Puntos donde vamos a interpolar
xi = -10 : 1 : 10;
yi = -20 : 1 : 20;
zi = -10 : 1 : 5;
[xgi, ygi, zgi] = meshgrid(yi, xi, zi);

% Plot de datos originales
k = 1;
figure(k)
hold on
slice(xg, yg, zg, dat, [-20, 0], [0, 10], [-10, 0]), shading flat
view([45 45])
title('Original data')

% Interpolación Hermite
dati = interp3(xg, yg, zg, dat, xgi, ygi, zgi, 'cubic')
k = k + 1;
figure(k)
hold on
slice(xgi, ygi, zgi, dati, [-20, 0], [0, 10], [-10, 0]), shading flat
view([45 45])
title('Hermit interpolation')





