% Master TECI
% Técnicas numéricas
% Práctica 4. Integración

% Ejercicio práctica 4
% Crear un script que permite aproxiima la integral de una función en
% dimensión 1 mediante una formula de Newton -Cotes de orden 3.

clear all
close all
clc
format long

% Valor exacto de la integral
valex1 = exp(1) - 1;

% Newton cotes orden 1
mettra1 = intep0(@func3tp4, 0, 1, 10000, 'tra')
mettra1 - valex1

% Newton cotes orden 2
metsim1 = intep2(@func3tp4, 0, 1, 10000)
metsim1 - valex1

% Newton cotes orden 3
metsim2 = intep3(@func3tp4, 0, 1, 10000)
metsim2 - valex1


