% Vectores, matrices y sus operaciones

% Creación de matrices
[1, 2, 3, 4]
[1, 2, 3]
[1; 2; 3]
[1, 2, 3]'
[1, 2; 3, 4]
M = [1, 2; 3, 4]
V = [1, 2]
MATO = ones(4, 4)
VECO1 = ones(1, 4)
VEC02 = ones(4, 1)
MATZ = zeros(4, 4)
MATD = diag([1, 2, 3, 4])
MATV = []

% Vectores y listas
V2 = 1 : 10
V3 = 1 : 0.5 : 3
V4 = 10 : -1 : 5
V5 = 5 : -1 : 10

% Operaciones
M * V'
det(M)
trace(M)
eig(M)   % Valores propios
norm(M, 1)
norm(M, 2)
norm(M, inf)
norm(V, 2)
norm(M)
norm(V)
M2 = [0, pi/2; pi, 3*pi/2]
cos(M2)
2 * V + 3
M2i = M2^(-1)
M2i * M2
M2i2 = inv(M2)
M2i2 * M2
M3 = [1, 2, 3; 4, 5, 6]
size(M3)
[rows, cols] = size(M3)
length(V)

% Coordenadas
M3(2, 2)
M3(2, 2) = 55
M3(:, 1)
M3(1, :)
V3 = [10; 11]
M3(:, 1) = V3
M3(1, 1 : 2)
M3(:, 1 : 2)
i = 2
V3(i)
V3(end)
V3(end - 1)
VECA = [1, 2, 3]
VECB = [4, 5, 6]
VECC = [VECA, VECB]










