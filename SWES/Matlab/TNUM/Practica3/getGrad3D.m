% Funcion obtención valor gradiente
% a partir de xgrid, ygrid, zgrid, gradx, grady y gradz

function [xg, yg, zg] = getGrad3D(xgrid, ygrid, zgrid, gradx, grady, gradz, x, y, z)
xgv = ceil(find(xgrid == x, 1) / length(xgrid));
ygv = ceil(find(ygrid == y, 1) / length(ygrid));
zgv = ceil(find(zgrid == z, 1) / length(zgrid));
xg = gradx(1, xgv);
yg = grady(1, ygv);
zg = gradz(1, zgv);
end