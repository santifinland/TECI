% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación

% Interpolación 1D

clear all
close all
clc
k = 1;

% Puntos de interpolación
x = [-1 5 8 10];
y = [0 6 2 5];
figure(k)
clf
plot(x, y, 'o')
title('Puntos de interpolación')

% Dibujo de interpolación lineal
k = k + 1;
figure(k)
clf
hold on
plot(x, y, 'o')
plot(x, y , 'r') % interpolación con recta roja
title('Puntos de interpolación. Interpolacion lineal')

% Intepolación lineal
xint = -1 : .1 : 10 % Puntos donde queremos aproximar la función
yint = interp1(x, y, xint)  % Interpolación lineal de dimensión 1 en los puntos xint
yint2 = interp1(x, y, xint, 'lineal')  % Interpolación lineal
norm(yint-yint2, 2) % Da 0 porque es lo mismo
% grafica 1
k = k + 1;
figure(k)
clf
plot(xint, yint, 'o')
title('Puntos interpolados')
% grafica 2
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint, 'go')
plot(xint, yint, 'r')
plot(x, y, 's')
title('Interpolacion lineal')

% Interpolación nearest
yint3 = interp1(x, y, xint, 'nearest')
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolación PWC')

% Interpolación spline cúbica o de Hermite
yint3 = interp1(x, y, xint, 'cubic')
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolación cubic (Hermite)')

% Interpolación spline
yint3 = interp1(x, y, xint, 'spline')
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolación Spline')

% Otra forma de conseguir interpolación spline similar a la anterior
yint3 = spline(x, y, xint)
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolación cubic (Spline - función spline)')

% Interpolación pchip (Hermite)
yint3 = pchip(x, y, xint)
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolación cubic (Hermit - función pchip)')









