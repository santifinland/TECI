% Otro ejemplo de funcion

% Funciónde R en R^2 (x) -> (sum(x), norm(x, 2))
function [J, N] = mifunc2(x)
N = norm(x, 2);
J = sum(x + 4);
end
