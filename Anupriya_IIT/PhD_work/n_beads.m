clear all; 
close all;

%define
Np=6; f = 1.0; kk = 1.0;
%variables
x0 = 1.0; y0 = 1.0; ri = 0.1;
r0 = 0.2; rm = 0.5; %did not change the values yet, kept as it was in two beads problem
%delX = ; 
%delX ,tauE and C have been taken arbitrarily to run the code.
tauE = 40; tauP = 0.5;
%C = 1
dt = 0.003; Nt = 1e4;
for i = 1:Np
    xx(1,i) = x0 +(i*ri); yy(1,i) = y0 +(i*ri);  %tried to write a row matrix ,checked all methods given online, but everytime ended with a column matrix.
end
vx(1:Nt,1:Np) = 0.0; vy(1:Nt,1:Np) = 0.0;


for it = 1:Nt-1
    for j = 1: Np-1
        delX = xx(it,j+1) - xx(it,j); %error shows : "Index in position 2 exceeds array bounds (must not exceed 1)."
        delY = yy(it,j+1) - yy(it,j);
        fj(j) = (1 - (delX^2 + delY^2)/rm^2)^(-1);
       % fj
    end
end
 for it =1: Nt-1   
        for ip = 1:Np
          ux = 0.5*f*sin(kk*xx(it,ip))*cos(kk*yy(it,ip)); 
          uy = -0.5*f*cos(kk*xx(it,ip))*sin(kk*yy(it,ip));
            if(ip==1)
                ax(it,ip) = ((ux -vx(it,ip))+(fj(ip)/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;
                ay(it,ip) = ((uy -vy(it,ip))+(fj(ip)/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;  %calculated for the inertial particle
                vx(it+1,ip) = vx(it,ip) + dt*ax(it,ip);
                vy(it+1,ip) = vy(it,ip) + dt*ay(it,ip);
           
           
            elseif (ip==Np)
                ax(it,ip) = ((ux -vx(it,ip))-(fj(ip-1)/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;
                ay(it,ip) = ((uy -vy(it,ip))-(fj(ip-1)/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;  %calculated for the inertial particle
                vx(it+1,ip) = vx(it,ip) + dt*ax(it,ip);
                vy(it+1,ip) = vy(it,ip) + dt*ay(it,ip);
                
                
            else
                vx(it+1,ip) = ux - ((fj(ip-1)-fj(ip))/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1);
                vy(it+1,ip) = uy - ((fj(ip-1)-fj(ip))/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1);
            end
        % calculated for all other particles
           
       
         end
  %--
  xx(it+1,:) = xx(it,:) + dt*vx(it,:);
  yy(it+1,:) = yy(it,:) + dt*vy(it,:);
end

%plot(xx(:,1),yy(:,1),'.-b')
%hold on;
%plot(xx(:,2),yy(:,2),'.-r')
%hold on;
%plot(xx(:,3),yy(:,3),'.-g')
%hold on;
%plot(xx(:,4),yy(:,4),'.-c)
%hold on;
%plot(xx(:,6),yy(:,1),'.-y');
for i = 1 : Np

plot( yy(i, :), xx(i, :), '-k')

end





