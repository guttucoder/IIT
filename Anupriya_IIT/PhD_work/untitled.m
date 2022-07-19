clear all; 
close all;

%define
Np=2; f = 1.0; kk = 1.0;
%variables
x0 = 1.0; y0 = 1.0; ri = 0.1;
r0 = 0.2; rm = 0.5;
%delX = ; 
%delX ,tauE and C have been taken arbitrarily to run the code.
tauE = 450; tauP = 0.5;
%C = 1
dt = 0.01; Nt = 1e4;
xx(1,:) = [1 1+ri]; yy(1,:) = [1 1+ri];
vx(1:Nt,1:Np) = 0.0; vy(1:Nt,1:Np) = 0.0;


for it = 1:Nt-1
    delX = xx(it,2) - xx(it,1);
    delY = yy(it,2) - yy(it,1);
    fj = (1 - (delX^2 + delY^2)/rm^2)^(-1);
    
  for ip = 1:Np
      if(ip==1)
          ux = 0.5*f*sin(kk*xx(it,ip))*cos(kk*yy(it,ip)); 
          uy = -0.5*f*cos(kk*xx(it,ip))*sin(kk*yy(it,ip));   
          ax(it,ip) = ((ux -vx(it,ip))+(fj/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;
          ay(it,ip) = ((uy -vy(it,ip))+(fj/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;
          vx(it+1,ip) = vx(it,ip) + dt*ax(it,ip);
          vy(it+1,ip) = vy(it,ip) + dt*ay(it,ip);
          
          %vy(it+1,ip) = uy + (C/tauE) * delX;
      end
      if(ip==2)
          ux = 0.5*f*sin(kk*xx(it,ip))*cos(kk*yy(it,ip)); 
          uy = -0.5*f*cos(kk*xx(it,ip))*sin(kk*yy(it,ip));   
          vx(it+1,ip) = ux - (fj/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1);
          vy(it+1,ip) = uy - (fj/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1);
          
          %vy(it+1,ip) = uy - (C/tauE) * delX;
      end
  end
  %--
  xx(it+1,:) = xx(it,:) + dt*vx(it,:);
  yy(it+1,:) = yy(it,:) + dt*vy(it,:);
end

plot(xx(:,1),yy(:,1),'.-b')
hold on;
plot(xx(:,2),yy(:,2),'.-r'); 



