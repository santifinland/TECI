% Master TECI
% Técnicas de Montecarlo
%
% Función Box Muller

% Imput parameter:
%   seed
% Output paramters:
%   x, y
%   

function [n1, n2, s] = BoxMuller(s, m, v)
  % Get u1 and u2 ramdom numbers
  [s, u1] = Congruencial(s);
  [s, u2] = Congruencial(s);
  n1 = sqrt(-2 * log(1 - u1)) * cos(2 * pi * (1 - u2));
  n2 = sqrt(-2 * log(1 - u1)) * sin(2 * pi * (1 - u2));
  
  n1 = n1 * v + m;
  n2 = n2 * v + m;
  
