% El uso del 'if'
clc
disp('Vamos a ver si X es más grande que Y')
x = input('Valor de x: ');
y = input('Valor de y: ');
disp(['x vale ' num2str(x)]);
disp(['y vale ' num2str(y)]);

if (x > y)
    disp(['x es más grande que y']);
elseif (x == y)
    disp(['x es igual a y']);
else
    disp(['x es más pequeño que y']);
end