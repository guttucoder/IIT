clear all
close all

n= 128; kk=1.0; f=1.0;

x = 1: ((2*pi)/n) :(2*pi);
y = 1: ((2*pi)/n) :(2*pi);

[X,Y] = meshgrid(x,y);
%Psi = (1/pi)*sin(pi*X).^2.*sin(pi*Y).^2;

u_x = 0.5*f*sin(kk*X).*cos(kk*Y);
u_y = -0.5*f*cos(kk*X).*sin(kk*Y);


%figure;
%contourf(X,Y,Psi)
%title('velocity field intensity')

figure;
quiver(X,Y,u_x,u_y)
%shading interp
%colorbar;

%surf (X,Y,u_x,u_y)
title('velocity field direction')
%% 
x = 0:0.1:3;
y = 0:0.1:3;

[X,Y] = meshgrid(x,y);
Psi = (1/pi)*sin(pi*X).^2.*sin(pi*Y).^2;

u_x =  2*(sin(pi*X).^2).*(sin(pi*Y)).*(cos(pi*Y));   
u_y = -2*(sin(pi*Y).^2).*(sin(pi*X)).*(cos(pi*X)); 

figure;
contourf(X,Y,Psi)
title('velocity field intensity')

figure;
quiver(X,Y,u_x,u_y)
title('velocity field direction')

