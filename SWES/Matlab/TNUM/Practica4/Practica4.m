% Master TECI
% Técnicas numéricas
% Práctica 4. Integración

% Práctica4
clear all
close all
clc
format long

disp('Primer caso: int(x^2), 0, 2')
valex1 = 2^3 / 3;
metmax1 = intep0(@func1tp4, 0, 2, 100, 'max')
metmax1 - valex1
metmin1 = intep0(@func1tp4, 0, 2, 100, 'min')
metmin1 - valex1
mettra1 = intep0(@func1tp4, 0, 2, 100, 'tra')
mettra1 - valex1
metsim1 = intep2(@func1tp4, 0, 2, 100)
disp('En este caso el metodo debería exacto (salvo errores numéricos')
metsim1 - valex1

metmax1p = intep0(@func1tp4, 0, 2, 10000, 'max')
metmax1p - valex1
metmin1p = intep0(@func1tp4, 0, 2, 10000, 'min')
metmin1p - valex1
mettra1p = intep0(@func1tp4, 0, 2, 10000, 'tra')
mettra1p - valex1
metsim1p = intep2(@func1tp4, 0, 2, 10000)
disp('Se amplian los errors')
metsim1p - valex1

disp('Segundo caso: (int(x^2), 2, 0) y (int(x^3), -2, 2')
intep0(@func1tp4, 2, 0, 10000, 'tra')
intep0(@func2tp4, -2, 2, 10000, 'tra')

disp('Tercer caso: (int(exp(x), 0, 1)')
valex2 = exp(1) - 1;
metmax2 = intep0(@func3tp4, 0, 1, 100, 'max')
metmax2 - valex2
metmin2 = intep0(@func3tp4, 0, 1, 100, 'min')
metmin2 - valex2
mettra2 = intep0(@func3tp4, 0, 1, 100, 'tra')
mettra2 - valex2
metsim2 = intep2(@func3tp4, 0, 1, 100)
metsim2 - valex2

metmax2p = intep0(@func3tp4, 0, 1, 10000, 'max')
metmax2p - valex2
metmin2p = intep0(@func3tp4, 0, 1, 10000, 'min')
metmin2p - valex2
mettra2p = intep0(@func3tp4, 0, 1, 10000, 'tra')
mettra2p - valex2
metsim2p = intep2(@func3tp4, 0, 1, 10000)
metsim2p - valex2

disp('Cuarto caso: (int(x^2 + y^2, 0, 2)')
valex3 = 2 / 3;
metmax3 = intep0d2(@func4tp4, 0, 1, 100, 0, 1, 100, 'max')
metmax3 - valex3
metmin3 = intep0d2(@func4tp4, 0, 1, 100, 0, 1, 100, 'min')
metmin3 - valex3
mettra3 = intep0d2(@func4tp4, 0, 1, 100, 0, 1, 100, 'tra')
mettra3 - valex3

metmax3p = intep0d2(@func4tp4, 0, 1, 500, 0, 1, 500, 'max')
metmax3p - valex3
metmin3p = intep0d2(@func4tp4, 0, 1, 500, 0, 1, 500, 'min')
metmin3p - valex3
mettra3p = intep0d2(@func4tp4, 0, 1, 500, 0, 1, 500, 'tra')
mettra3p - valex3



