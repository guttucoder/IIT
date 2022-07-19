clear all;
close all;

%define
Np=4;
f = 1.0; kk = 1.0; kk = 1.0;;
%variables
x0 = 1.0;
y0 = 1.0;
x2-x1 = 0.02;
l = 0.1;
dt = 0.05;
Nt = 1000;
xx(1:Nt,1:Np) = 0.0;
yy(1:Nt,1:Np) = 0.0;
vx(1:Nt,1:Np) = 0.0;
vy(1:Nt,1:Np) = 0.0;

for ip = 1:Np
xx(1,ip) = x0; yy(1,ip) = y0;
vx(1,ip) = 0.; vy(1,ip) = 0.;
end
tau = [0,0.2,0.5,1];

for it = 1:Nt-1
  for ip = 1:Np
ux = 0.5*f*sin(kk*xx(it,ip))*cos(kk*yy(it,ip)); 
uy = -0.5*f*cos(kk*xx(it,ip))*sin(kk*yy(it,ip));
if(ip==1)
vx(it+1,ip) = ux;
vy(it+1,ip) = uy;
else
ax = -(vx(it,ip)-ux)/tau(ip);
ay = -(vy(it,ip)-uy)/tau(ip);
vx(it+1,ip) = vx(it,ip) + dt*ax;
vy(it+1,ip) = vy(it,ip) + dt*ay;
end
  end
%--
xx(it+1,:) = xx(it,:) + dt*vx(it,:);
yy(it+1,:) = yy(it,:) + dt*vy(it,:);
end

plot(xx(:,1),yy(:,1),'.-b')
hold on;plot(xx(:,2),yy(:,2),'.-r'); hold off;
hold on;plot(xx(:,3),yy(:,3),'.-m'); hold off;
hold on;plot(xx(:,4),yy(:,4),'.-k'); hold off;



