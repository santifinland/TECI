% Creación de una función

% Como se requiere tener un "main" si tengo funciones en mi fichero,
% es mejor tener un fichero por función

% Función de R^2 en R: (x, y) -> x^2 + y^3
function [J] = mifunc(x, y)
J = x^2 + y^3;
end

