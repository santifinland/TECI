% Funcion obtención valor gradiente
% a partir de xgrid, ygrid, gradx y grady

function [xg, yg] = getGrad2D(xgrid, ygrid, gradx, grady, x, y)
xgv = ceil(find(xgrid == x, 1) / length(xgrid));
ygv = ceil(find(ygrid == y, 1) / length(ygrid));
xg = gradx(1, xgv);
yg = grady(1, ygv);
end
