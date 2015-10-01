clear all
close all
clc
x=0 :.1 :1 ;
for i=1 :length(x) y(i)=fun1p5(x(i)) ; end
figure(1)
clf
hold on
plot(x,y)
[xsol,fval,exitflag,output] = fzero(@fun1p5,-1)
[xsol,fval,exitflag,output] = fsolve(@fun1p5,-1)
plot(xsol,fval,'ok','markersize',10,'linewidth',10)
x=-1 :.1 :1 ;
y=-1 :.1 :1 ;
for i=1 :length(x)
for j=1 :length(x) t=[x(i),y(j)] ; J=fun2p5(t) ; z1(i,j)=J(1) ; z2(i,j)=J(2) ;
end
end
[yy,xx]=meshgrid(x,y) ;
figure(2)
clf
hold on
surface(xx,yy,z1)
figure(3)
clf
hold on
surface(xx,yy,z2)
[xsol,fval,exitflag,output] = fsolve(@fun2p5,[1,1])
figure(2)
plot3(xsol(1),xsol(2),fval,'ok','markersize',10,'linewidth',10)
figure(3)
plot3(xsol(1),xsol(2),fval,'ok','markersize',10,'linewidth',10)
