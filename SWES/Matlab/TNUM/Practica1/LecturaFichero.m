% Lectura de ficheros

% Escritura previa
AA = [1 2 3 ...  % Los tres puntos permiten seguir en la siguiente linea
    4 5 6 7 8]
disp('Escritura en el DD')
fid = fopen(['results.txt'], 'w');
fprintf(fid, 'Vector AA:\n');
fprintf(fid, '%0.12f\n', AA);
fclose(fid);
disp('Lectura en el DD')
fid = fopen('results.txt', 'r');
text = fgets(fid)   % fgets coge una línea
AAR(1) = str2num(fgets(fid))
AAR(2) = str2num(fgets(fid))
afin = fscanf(fid, '%g') % fscan lee todo el fichero a partir del puntero actual
AAR = [AAR afin']
fclose(fid);
