% Master TECI
% T�cnicas de Montecarlo
%
% Pr�ctica 1: modelo log�stico de crecimiento poblacional


%   P = crecimientoPoblacional(tipo,P0,a,b,dt,Tmax) Es una funci�n que 
%   calcula el crecimiento de una poblaci�n.
%   Argumentos:
%       tipo:   Tiene dos posibles valores 'log' para utilizar la ecuaci�n 
%               log�stica y 'gom' para utilizar la ecuaci�n de Gompertz.
%       Po:     Tama�o inicial de la poblaci�n.
%       a:      Tasa de crecimiento de la poblaci�n.
%       b:      Tasa de mortalidad de la poblaci�n.
%       dt:     Incremento de tiempo.
%       Tmax:   M�ximas unidades de tiempo.
%   
%   Salidas:
%       P:      Tama�o final de la poblaci�n
%       pasos:  N�mero de pasos necesarios para llegar a las m�ximas 
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



