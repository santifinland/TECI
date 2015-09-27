% Tecnicas Numericas
% Ejercicio 2 de la práctica 1

% Programar una función nprimo(n) que calcula el n-esimo numero primo
% verificando si la entrad 'n' dad es un numero natural, si no, devuelve
% un mensaje de error 'n no es un numero natural'

function p = nPrimeSan(n)
if (mod(n, n) ~= 0)
    disp([num2str(n) ' no es un numero natural']);
else
    i = 2;
    accp = 0;
    p = 0;
    while (accp ~= n)
        if (isPrimeSan(i))
            accp = accp + 1;
            p = i;
        end
        i = i + 1;
    end
end

        
        