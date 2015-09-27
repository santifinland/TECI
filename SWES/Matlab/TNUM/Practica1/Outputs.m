% Outputs

% Output textual
disp('Hola')
disp([]) % Salto de linea
MESS1 = 'El valor de x es: '
x = 10
MESS2 = [MESS1 num2str(x)]
disp(MESS2)

% Output en ficheros
diary('test.txt') % Crea un fichero text.txt
diary on
1 + 1
MESS1 = 'Se acabó!'
disp(MESS1)
diary off
result = [1 3 10]
fid = fopen(['results.txt'], 'w');
fprintf(fid, 'Final point:\n');
fprintf(fid, '%0.12f\n', result);
fprintf(fid, 'or:\n');
fprintf(fid,[num2str(result) '\n']);
fclose(fid);
