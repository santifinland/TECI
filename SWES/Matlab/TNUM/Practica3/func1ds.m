% Master TECI
% T�cnicas num�ricas
% Pr�ctica 3. Derivaci�n

% Derivada segunda de la funci�n a derivar
function f = func1ds(x)
f = 2 * pi * (sin(cos(x) * 2 * pi) * sin(x) * 2 * pi *(-sin(x)) - cos(x) * cos(cos(x) * 2 * pi));
end
