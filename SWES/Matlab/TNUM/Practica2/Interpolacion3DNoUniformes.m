% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación

% Interpolación 3D de datos no uniformes
clear all
close all
clc

% Creación de datos
x = [-9 5 9 0 4 3 6 8];
y = [-1 2 -5 8 9 1 7 -8];
z = [1 0 5 9 3 -6 -5 -9];
dat = [0 1 2 5 -5 6 3 4];

% Puntos de interpolación
xi = -10 : 1 : 10;
yi = -20 : 1 : 20;
zi = -10 : 1 : 5;
[xgi, ygi, zgi] = meshgrid(yi, xi, zi);

% Interpolación lineal
dati = griddata(x, y, z, dat, xgi, ygi, zgi, 'linear');
figure(1)
hold on
slice(xgi, ygi, zgi, dati, [-20 : 3 : 20], [-10 : 3 : 10], [-10 : 3 : 5]), shading flat
plot3(x, y, z, 'o')
view([45 45])
title('Linear interpolation')


