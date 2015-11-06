% Generador Aleatorio

x = 123456789;
v = zeros(40, 1);
for i = 1:100
    [x, u] = Congruencial(x);
    v(i) = u;
end

meamv = mean(v)
varv = var(v)

v05tmp = v * 3
v05 = v05tmp + 2

meamv05 = mean(v05)
varv05 = var(v05)
