% Master TECI
% Técnicas de montecarlo
%
% Generadores aleatorios congruenciales

% Imput parameter:
%   seed
% Output paramters:
%   new seed
%   ramdom number

function [xn, un] = Congruencial(x)
a = 16807;
b = 0;
m = 2^31 - 1;

yn = a * x + b;
xn = mod(yn, m);
un = xn / m;



