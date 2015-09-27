% Output gráfico

% En dimensión 1
dat = 1 : .1 : 10;
resdat = cos(dat);
figure(1)
clf
plot(dat, resdat)
grid on  % Añade una malla en el fondo
xlabel('Data')
ylabel('Result')

dat2 = 1 : .1 : 10;
resdat2 = sin(dat2);
figure(2)
clf
subplot(2, 1, 1)
plot(dat, resdat, 'color', [1 0 0]) % Las ultimas cifras son Red Blue Green
title('Cos')
subplot(2, 1, 2)
plot(dat2, resdat2, 'color', [0 1 0], 'linewidth', 2)
title('Sin')

figure(3)
clf
hold on
plot(dat, resdat, 'color', [1 0 0])
plot(dat2, resdat2, 'color', [0 1 0], 'linewidth', 3)
legend('Cos', 'Sin')
saveas(gcf, 'test', 'jpg')
close all


% En dimension 2
x = -20 : 1 : 20;
y = -30 : 1 : 30;
A = rand(length(x), length(y));
[Xgrid, Ygrid] = meshgrid(x, y);
figure(1)
clf
surface(Xgrid, Ygrid, A')
xlabel('xdata')
ylabel('ydata')
zlabel('result')
view(45, 45)



