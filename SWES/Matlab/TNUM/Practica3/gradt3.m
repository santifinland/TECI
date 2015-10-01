% Master TECI
% T�cnicas num�ricas
% Pr�ctica 3. Derivaci�n

% Ejercicio pr�ctica 3

% Datos de la funci�n a derivar y calculo del gradiente y hessianas exactos
clear all
close all
clc
x = -2;
y = 9;
z = 3;

% funci�n original func3
% Gradiente excto: func3g
grad = func3g([x, y, z])

% gradiente aproximado.
% C�lculo del gradiente mediante una aproximaci�nde Taylor centrada
eps = 1e-4
zpx = func3([x + eps, y, z])
zmx = func3([x - eps, y, z])
gtx = (zpx - zmx) / (2 * eps)

zpy = func3([x, y + eps, z]);
zmy = func3([x, y - eps, z]);
gty = (zpy - zmy) / (2 * eps);
            
zpz = func3([x, y, z + eps]);
zmz = func3([x, y, z - eps]);
gtz = (zpz - zmz) / (2 * eps);
(grad)
[gtx, gty, gtz]      
