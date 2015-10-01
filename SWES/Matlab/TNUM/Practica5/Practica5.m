% Master TECI
% Práctica 5

% Sistemas lineales
A = [1, 2, 3; 0, 1, 6; 4, 2, 0]
b = [1; 5; 7]
det(A)
u = A^-1 * b
A * u - b
linsolve(A, b)

A = [1, 2, 3; 0, 1, 6]
b = [1; 5]
u = linsolve(A, b)

A = [1, 2, 3; 0, 1, 6; 1, 2, 0; 1, 0, 1]
b = [1; 1; 1; 1]
u = linsolve(A, b)
A * u
