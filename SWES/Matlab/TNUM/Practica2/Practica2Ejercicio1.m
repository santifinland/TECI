% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación
% Ejercicio 1:

% Programar una funcion sol = minterp(x, y, t, met) donde x representa los
% puntos de mediciones, y los datos, y t los puntos de interpolación que
% devuelve en función de la cadena met

% Datos observados
x = [-10 -3 0 2 5 10];
y = [ -5 0 1 5 2 5];

% Puntos a interpolar
t = -10 : .1 : 10;

% Obtención de los puntos interpolados
solLineal = minnterp(x, y, t, 'linear');
solLagrange = minnterp(x, y, t, 'lagrange');
solLagrangeCoef = minnterp(x, y, t, 'lagrangeCoef');

% Plot de los datos interpolados
figure(1)
clf
hold on
plot(x, y, 'go')
plot(t, solLineal, 'r')
plot(t, solLagrange, 'g')
plot(t, solLagrangeCoef, '-.k')
title('Interpolación miinterp linear')



