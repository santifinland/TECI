% Master TECI
% Técnicas numéricas
% Práctica 4. Integración

% Metodo de Newton Codes P0 o el prisma en dimensión 2
function j = intep0d2(f, a, b, n, c, d, m, type)
intervx = a : (b - a) / (n - 1) : b;
intervy = a : (d - c) / (n - 1) : b;
j = 0;
for ii = 1 : length(intervx) - 1
    for jj = 1 : length(intervy) - 1
        xa = intervx(ii);
        xb = intervx(ii + 1);
        ya = intervy(jj);
        yb = intervy(jj + 1);
        if type == 'max'
            fb = max([f(xa, ya), f(xa, yb), f(xb, ya), f(xb, yb)]);
        elseif type == 'min'
            fb = min([f(xa, ya), f(xa, yb), f(xb, ya), f(xb, yb)]);
        elseif type == 'tra'
            fb = ([f(xa, ya) + f(xa, yb) + f(xb, ya) + f(xb, yb)]) / 4;
        end
        j = j + fb * (xb - xa) * (yb - ya);
    end
end
end

