% Master TECI
% Técnicas de Montecarlo
%
% Generacion de normales usando una función Box Muller

function [distnormal] = GeneradorNormal(n, m, v)
    s = 123456789;

    vn1 = zeros(n / 2, 1);
    vn2 = zeros(n / 2, 1);
    distnormal = zeros(n, 1);
    
    for i = 1:n/2
        [n1, n2, s] = BoxMuller(s, 0, 1);
        vn1(i) = n1;
        vn2(i) = n2;
    end
    
    distnormal = cat(1, vn1, vn2);
    distnormal = distnormal * v;
    distnormal = distnormal + m;