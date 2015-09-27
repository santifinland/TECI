% Master TECI
% Técnicas numéricas
% Práctica 2: Interpolación
% Ejercicio 1:

% Programar una funcion sol = minterp(x, y, t, met) donde x representa los
% puntos de mediciones, y los datos, y t los puntos de interpolación que
% devuelve en función de la cadena met

function r = minnterp(x, y, t, met)
if (strcmp(met, 'linear'))
    tic;
    r = [];
    for i = 1 : length(x) - 1
        for j = 1 : length(t)
            if ((t(j) >= x(i)) && (t(j) <= x(i + 1)))
                r(j) = y(i) + (t(j) - x(i)) * (y(i + 1) - y(i)) / (x(i + 1) - x(i));
            end
        end
    end
    disp(['Interpolación lineal ha tardado ' num2str(toc) ' segundos']);
elseif (strcmp(met, 'lagrange'))
    tic;
    r = zeros(1, length(t));
    for k = 1 : length(t)
        for i = 1 : length(x)
            producto = y(i);
            for j = 1 : length(x)
                if i ~= j
                    producto = producto * (t(k) - x(j)) / (x(i) - x(j));
                end
            end
            r(k) = r(k) + producto;
        end
    end
    disp(['Interpolación Lagrange ha tardado ' num2str(toc) ' segundos']);
elseif (strcmp(met, 'lagrangeCoef'))
    tic
    n = length(x);
    % Para cada abcisa, sacamos su coeficiente de Lagrange.
    for i = 1 : n
        V = 1;
        % El coeficiente de Lagrange es el pruducto de los binomios de sus
        % raices.
        for j = 1 : n
            % Evitamos el caso i = j que haría el coeficiente 0.
            if i ~= j
                % poly expresa un polinomio en función de sus raices
                % conv permite la multiplicación de polinomios
                % En cada iteración multiplicamos por el resultado de la
                % iteración anterior ya que es un productorio.
                V = conv(V, poly(x(j))) / (x(i) - x(j));
            end
        end
        % Almacenamos en cada fila de la matriz L, el polinomio
        % correspondiente al coeficiente de Lagrange para cada abcisa.
        L(i, :) = V;
    end
    % Realizamos el sumatorio de los coeficientes de Lagrange multiplicados
    % por cada ordenada como un producto de vector y por matriz L.
    C = y * L;
    % Evaluamos el polinomio en cada abcisa a interpolar.
    for i = 1 : length(t)
        r(i) = polyval(C, t(i));
    end
    disp(['Interpolación Lagrange calculando primero coeficientes ha tardado ' num2str(toc) ' segundos']);
end