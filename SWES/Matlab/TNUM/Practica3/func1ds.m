% Master TECI
% Técnicas numéricas
% Práctica 3. Derivación

% Derivada segunda de la función a derivar
function f = func1ds(x)
f = 2 * pi * (sin(cos(x) * 2 * pi) * sin(x) * 2 * pi *(-sin(x)) - cos(x) * cos(cos(x) * 2 * pi));
end
