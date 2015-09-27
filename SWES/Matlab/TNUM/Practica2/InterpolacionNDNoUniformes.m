

% Interpolación en dimensiones superiores de datos no uniformes
clear all
close all
clc

% Creación de datos
x = [-9 5 9 0 4 3 6 8];
y = [-1 2 -5 8 9 1 7 -8];
z = [1 0 5 9 3 -6 -5 -9];
k = [9 8 5 -9 -3 7 -1 -10];
dat = [0 1 2 5 -5 6 3 4];
xi = -10 : 1 : 10;
yi = -20 : 1 : 20;
zi = -10 : 1 :5;
ki = -10 : 1 : 10;
[xgi, ygi, zgi, kgi] = ndgrid(xi, yi, zi, ki);

XO = [x(:), y(:), z(:), k(:)];
XI = [xgi(:), ygi(:), zgi(:), kgi(:)];
dati = griddatan(XO, dat', XI, 'linear');
datim = reshape(dati, size(ygi));