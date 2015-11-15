% Master TECI
% Técnicas de Montecarlo
%
% Práctica 1: modelo logístico de crecimiento poblacional


%   P = crecimientoPoblacional(tipo,P0,a,b,dt,Tmax) Es una función que 
%   calcula el crecimiento de una población.
%   Argumentos:
%       tipo:   Tiene dos posibles valores 'log' para utilizar la ecuación 
%               logística y 'gom' para utilizar la ecuación de Gompertz.
%       Po:     Tamaño inicial de la población.
%       a:      Tasa de crecimiento de la población.
%       b:      Tasa de mortalidad de la población.
%       dt:     Incremento de tiempo.
%       Tmax:   Máximas unidades de tiempo.
%   
%   Salidas:
%       P:      Tamaño final de la población
%       pasos:  Número de pasos necesarios para llegar a las máximas 
%               unidades de tiempo.
%   Ejemplo:
%      [P, pasos] = crecimientoPoblacional('log',150,0.01,1000,0.1,1000)
function [P, pasos] = crecimientoPoblacional(tipo,Po,a,b,dt,Tmax)
P=Po;
pasos=0;
if(strcmp(tipo,'log'))
    for i=dt:dt:Tmax
        Paux=P+(a*P-(a/b)*P^2)*dt;
        P=max(Paux,0);
        pasos=pasos+1;
    end
else
    if(strcmp(tipo,'gom'))
        for i=dt:dt:Tmax
            Paux=P+(a*P*log(b/P))*dt;
            P=max(Paux,0);
            pasos=pasos+1;
        end
    end
end



