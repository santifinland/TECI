% Master TECI
% Técnicas numéricas
% Práctica 3. Derivación

% Derivación en dimensión 1

% Datos de la función a derivar
clear all
close all
clc
x = 0 : .1 : 2 * pi;
y = func1(x);

% Datos de la derivada primera
for i = 1 : length(x)
    yd(i) = func1d(x(i));
end

% Dibujamos gráficamente la función y su derivada
figure(1)
clf
hold on
plot(x, y, 'r')
plot(x, yd, 'b')
axis tight

% Calculo de la derivada primera mediante la aproximación de Taylor de un solo
% punto
disp('Calculo de la derivada primera mediante una aproximación de taylor de un solo punto.')
derivt1 = [];
eps = 1e-6;
for i = 1 : length(x)
    yt = func1(x(i));
    yl = func1(x(i) + eps);
    derivt1(i) = (yl - yt) / eps;
end
figure(1)
plot(x, derivt1, '-.g')
errt1 = norm(derivt1 - yd, 2);
disp(['Error Taylor 1 punto: ', num2str(errt1)])

% Calculo de la derivada primera mediante la aproximación de Taylor centrada
disp('Calculo de la derivada primera mediante una aproximación de taylor centrada.')
derivt2 = [];
for i = 1 : length(x)
    yp = func1(x(i) + eps);
    ym = func1(x(i) - eps);
    derivt2(i) = (yp - ym) / (2 * eps);
end
figure(1)
plot(x, derivt2, ':r')
errt1 = norm(derivt2 - yd, 2);
disp(['Error Taylor 1 punto: ', num2str(errt1)])


% Cálculo de la derivada segunda mediante aproximación de Taylor
disp('Calculo de la derivada segunda mediante una aproximación de Taylor')
for i = 1 : length(x)
    yds(i) = func1ds(x(i));
end
figure(2)
clf
hold on
plot(x, y, 'r')
plot(x, yds, 'b')
axis tight
derivts = [];
for i = 1 : length(x)
    yr = func1(x(i));
    yp = func1(x(i) + eps);
    ym = func1(x(i) - eps);
    derivts(i) = (yp - 2 * yr + ym) / (eps^2);
end
figure(2)
plot(x, derivts, ':g')
errts = norm(derivts - yds, 2);
disp(['Error Taylor centrado derivada segunda: ', num2str(errts)]);











