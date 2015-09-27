% Tecnicas Numericas
% Ejercicio a de la práctica 1

% b) Dibujar esta función en [-pi, pi] x [-2pi, pi] con un paso de 0.1

% Ejes donde vamos a dibujar la función, paso y grid
x = [-pi : .1 : pi]
y = [2 * -pi : .1 : 2 * pi]
[xx, yy] = meshgrid(y, x);

% Obtención del valor de la función en cada punto de la malla
for ii = 1 : length(x);
    for jj = 1 : length(y);
        zz(ii, jj) = coseno2seno(x(ii), y(jj));
    end
end

% Dibujamos la función con surface
figure(1)
clf
hold on
surface(xx, yy, zz);
view([45 45])
axis('tight')
