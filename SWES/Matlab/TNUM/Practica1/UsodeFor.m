% Uso del 'for'

clc % borra los datos anteriores
disp('Vamos a calcular la raiz d elos diez primeros numeros enteros y los guardamos en una lista')
lr = [] % lista vac�a
for i = 1 : 1 : 10
    lr(i) = sqrt(i);
    disp(['la ra�z de ' num2str(i) ' es ' num2str(lr(i))]);
end

% Este c�digo es similar a sqrt(1 : 10)
num2str(sqrt(1 : 10)')