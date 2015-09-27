% Uso del 'for'

clc % borra los datos anteriores
disp('Vamos a calcular la raiz d elos diez primeros numeros enteros y los guardamos en una lista')
lr = [] % lista vacía
for i = 1 : 1 : 10
    lr(i) = sqrt(i);
    disp(['la raíz de ' num2str(i) ' es ' num2str(lr(i))]);
end

% Este código es similar a sqrt(1 : 10)
num2str(sqrt(1 : 10)')