% Técnicas numéricas
% Práctica 3. Derivación

% Derivación en dimensión 2

% Matriz hessiana de func2
function hess = func2h(x)
hess(1) = 2;
hess(2) = 0;
hess(3) = 0;
hess(4) = -sin(x(2));
end
