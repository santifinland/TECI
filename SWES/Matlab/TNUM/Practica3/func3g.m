% T�cnicas num�ricas
% Pr�ctica 3. Derivaci�n

% Derivaci�n en dimensi�n 3

% Graciente de func3
function grad = func3g(x)
grad(1) = -2 * x(1) * exp(-x(1)^2);
grad(2) = -sin(x(2));
grad(3) = -cos(x(3));
end
