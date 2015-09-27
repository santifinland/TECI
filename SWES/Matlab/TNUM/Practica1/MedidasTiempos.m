% MedidaTiempo

clc
disp('Hola')
x = 10;
disp(['x vale ' num2str(x)])
x = x + 1
disp(['Y ahora vale ' num2str(x)])
disp([]) % Salto de linea
tic % Inicio de temporizador
a = input('Entrar el valor de a: ');
atime = ceil(toc); % Finalización de temporizador
disp(['a vale ' num2str(a) ' y has tardado ' num2str(atime) ' segundos en responder']);

tic
pause(.5) % Espera de 0.5 segundos
atime = toc; % Finalización de temporizador
