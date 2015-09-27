% Condiciones

% Test lógicos
x = 1
(x > 1)  % Devuelve un booleano (0) que no es tal
(x >= 1)
(x < 5)
(x <= 10)
(x == 1)
%(x = 1)  Esto falla
isa(x, 'numeric')
y = 'aaa'
isa(y, 'char')
isa(y, 'logical')
isa((y > 1), 'logical')
exist x
exist xx

% Operaciones
x = 1
y = 2
(x == 1) & (y == 2)
(x == 1) | (y > 2)
xor((x==1), (y > 2))

