% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación

% Interpolación en dimensiones superiores de datos uniformes
clear all
close all
clc

% Creación de datos
x = -10 : 10 : 10;
y = -20 : 10 : 20;
z = -10 : 10 : 10;
k = -30 : 10 : 30;
[xg, yg, zg, kg] = ndgrid(x, y, z, k);

for ii = 1 : length(x)
    for jj = 1 : length(y)
        for kk = 1 : length(z)
            for ll = 1 : length(k)
                dat(ii, jj, kk, ll) = x(ii)^2 + y(jj)^2 + z(kk)^2 + k(ll)^2;
            end
        end
    end
end

% Puntos donde vamos a interpolar
xi = -10 : 10 : 10;
yi = -20 : 10 : 20;
zi = -10 : 10 : 10;
ki = -30 : 10 : 30;
[xgi, ygi, zgi, kgi] = ndgrid(yi, xi, zi, ki);

% Interpolacion cubic
dati = interpn(xg, yg, zg, kg, dat, xgi, ygi, zgi, kgi, 'cubic');
figure(1)
hold on
plot(x, dat(:, 1, 1, 1), 'b')
plot(xi, dati(:, 1, 1, 1), 'r')
title('Comparision of some data')
legend('Original', 'Interpolated')
