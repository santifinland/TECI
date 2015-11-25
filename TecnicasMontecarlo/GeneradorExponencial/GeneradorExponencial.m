% Generador de distribución exponencial

function [distexponencial] = GeneradorExponencial(n, a)
    x = 123456789;
    distexponencial = zeros(n, 1);
    for i = 1:n
        [x, u] = Congruencial(x);
        distexponencial(i) = - log(u) / a;
    end

