
close all;

%define
Np=2;
f = 1.0; kk = 1.0;
%variables
x0 = 1.0;
y0 = 1.0;
delX = 0.02;            %delX ,tauE and C have been taken arbitrarily to run the code.
tauE = 0.1;
C = 1;
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
tau = [0.2,0];

for it = 1:Nt-1
  for ip = 1:Np
%ux = 0.5*f*sin(kk*xx(it,ip))*cos(kk*yy(it,ip)); 
%uy = -0.5*f*cos(kk*xx(it,ip))*sin(kk*yy(it,ip));
ux = 0;
uy = 0;
if(ip==1)
vx(it+1,ip) = ux + (C/tauE) * delX;
vy(it+1,ip) = uy ;
%vy(it+1,ip) = uy + (C/tauE) * delX;
end
if(ip==2)
vx(it+1,ip) = vx(it,ip) + (dt * vx)/tauE;
vy(it+1,ip) = vy(it,ip) + (dt * vy)/tauE;
%vy(it+1,ip) = uy - (C/tauE) * delX;
end
  end
%--
xx(it+1,:) = xx(it,:) + dt * vx(it,:);
yy(it+1,:) = yy(it,:) + dt * vy(it,:);
end
plot(xx(:,1),yy(:,1),'.-b')
hold on;plot(xx(:,2),yy(:,2),'.-r'); hold off;
%hold on;plot(xx(:,3),yy(:,3),'.-m'); hold off;
%hold on;plot(xx(:,4),yy(:,4),'.-k'); hold off;