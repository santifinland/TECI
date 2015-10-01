% Master TECI
% T�cnicas num�ricas
% Pr�ctica 4. Integraci�n

% Funci�n de aproximaci�n de integraci�n. Newton cotes de orden 2: Simpson
% cerrado.
function j = intep2(f, a, b, n)
interv = a : (b - a) / (n - 1) : b;
j = 0;
for ii = 1 : length(interv) - 1
    fb0 = f(interv(ii));
    fb1 = f((interv(ii) + interv(ii + 1)) / 2);
    fb2 = f(interv(ii + 1));
    h = ((interv(ii + 1) - interv(ii)) / 2);
    j = j + (h / 3) * (fb0 + 4 * fb1 + fb2);
end
end
