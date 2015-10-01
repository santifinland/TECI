% Master TECI
% Técnicas numéricas
% Práctica 4. Integración

% Función de aproximación de integración. Newton cotes de orden 3:
function j = intep3(f, a, b, n)
interv = a : (b - a) / (n - 1) : b;
j = 0;
for ii = 1 : length(interv) - 1
    h = ((interv(ii + 1) - interv(ii)) / 3);
    fb0 = f(interv(ii));
    fb1 = f(interv(ii) + h);
    fb2 = f(interv(ii) + 2 * h);
    fb3 = f(interv(ii + 1));
    j = j + (h / 8) * (3 * fb0 + 9 * fb1 + 9 * fb2 + 3 * fb3);
end
end