% Master TECI
% T�cnicas num�ricas
% Pr�ctica 4. Integraci�n

% Funci�n de aproximaci�n de integraci�n. Newton cotes de orden 3:
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