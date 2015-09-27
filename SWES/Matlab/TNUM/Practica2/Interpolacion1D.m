% Master TECI
% T�cnicas num�ricas
% Pr�ctica 2: Interpolaci�n

% Interpolaci�n 1D

clear all
close all
clc
k = 1;

% Puntos de interpolaci�n
x = [-1 5 8 10];
y = [0 6 2 5];
figure(k)
clf
plot(x, y, 'o')
title('Puntos de interpolaci�n')

% Dibujo de interpolaci�n lineal
k = k + 1;
figure(k)
clf
hold on
plot(x, y, 'o')
plot(x, y , 'r') % interpolaci�n con recta roja
title('Puntos de interpolaci�n. Interpolacion lineal')

% Intepolaci�n lineal
xint = -1 : .1 : 10 % Puntos donde queremos aproximar la funci�n
yint = interp1(x, y, xint)  % Interpolaci�n lineal de dimensi�n 1 en los puntos xint
yint2 = interp1(x, y, xint, 'lineal')  % Interpolaci�n lineal
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

% Interpolaci�n nearest
yint3 = interp1(x, y, xint, 'nearest')
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolaci�n PWC')

% Interpolaci�n spline c�bica o de Hermite
yint3 = interp1(x, y, xint, 'cubic')
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolaci�n cubic (Hermite)')

% Interpolaci�n spline
yint3 = interp1(x, y, xint, 'spline')
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolaci�n Spline')

% Otra forma de conseguir interpolaci�n spline similar a la anterior
yint3 = spline(x, y, xint)
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolaci�n cubic (Spline - funci�n spline)')

% Interpolaci�n pchip (Hermite)
yint3 = pchip(x, y, xint)
k = k + 1;
figure(k)
clf
hold on
plot(xint, yint3, 'go')
plot(xint, yint3, 'r')
plot(x, y, 's')
title('Interpolaci�n cubic (Hermit - funci�n pchip)')









