clear all; 
close all;

%define
Np=20; f = 1.0; kk = 1.0;
%variables
x0 = 0.1; y0 = 0.1; ri = 0.01;
r0 = 0.2; rm = 2; %did not change the values yet, kept as it was in two beads problem
%delX = ; 
%delX ,tauE and C have been taken arbitrarily to run the code.
tauE = 100; tauP = 0.5;
%C = 1
dt = 0.005; Nt = 5000;


%Initial Condition
xx(1:Nt,1:Np) = 0.0; yy(1:Nt,1:Np) = 0.0;
for i = 1:Np
    xx(1,i) = x0 +(i*ri) ;
    yy(1,i) = y0 +(i*ri) ; %tried to write a row matrix ,checked all methods given online, but everytime ended with a column matrix.
end

vx(1:Nt,1:Np) = 0.0; vy(1:Nt,1:Np) = 0.0;

for j = 1: Np-1
    delX = xx(1,j+1) - xx(1,j); %error shows : "Index in position 2 exceeds array bounds (must not exceed 1)."
    delY = yy(1,j+1) - yy(1,j);
    fj(j) = (1 - (delX^2 + delY^2)/rm^2)^(-1);
end

%Evolution
 for it = 2: Nt  
        for ip = 1:Np
            
          ux(it,ip) = 0.5*f*sin(kk*xx(it-1,ip))*cos(kk*yy(it-1,ip)); 
          uy(it,ip) = -0.5*f*cos(kk*xx(it-1,ip))*sin(kk*yy(it-1,ip));
          
            if(ip==1)
                
                ax(it,ip) = ((ux(it,ip) -vx(it-1,ip))+(fj(ip)/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;
                ay(it,ip) = ((uy(it,ip) -vy(it-1,ip))+(fj(ip)/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;  %calculated for the inertial particle
                vx(it,ip) = vx(it-1,ip) + dt*ax(it-1,ip);
                vy(it,ip) = vy(it-1,ip) + dt*ay(it-1,ip);
           
            elseif(ip==Np)
                
                vx(it,ip) = ux(it,ip) - (fj(ip-1)/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1);
                vy(it,ip) = uy(it,ip) - (fj(ip-1)/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1);
                
               
            else
                vx(it,ip) = ux(it,ip) + ((fj(ip)-fj(ip-1))/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1);
                vy(it,ip) = uy(it,ip) + ((fj(ip)-fj(ip-1))/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1);
            end
        % calculated for all other particles
           
       
         end
  %--
  xx(it,:) = xx(it-1,:) + dt*vx(it-1,:);
  yy(it,:) = yy(it-1,:) + dt*vy(it-1,:);
  
  for j = 1: Np-1
    delX = xx(it,j+1) - xx(it,j); %error shows : "Index in position 2 exceeds array bounds (must not exceed 1)."
    delY = yy(it,j+1) - yy(it,j);
    fj(j) = (1 - (delX^2 + delY^2)/rm^2)^(-1);
  %  save ('home/anupriya/Desktop/Anupriya/PhD_work/Anupam_gupta/codesfj_values.odt/',fj)  
 % fj
  end
  
end

u= sqrt(ux.*ux + uy.*uy);
v= sqrt(vx.*vx + vy.*vy);

n=128;h=(2*pi)/n; %!!!!!!!!! This gives the grid points
x_grid=0:h:2*pi-h;
y_grid=0:h:2*pi-h;
[X,Y]=meshgrid(x_grid,y_grid);
fig1=figure(6);
%surf(ux);  
quiver(X,Y,ux,uy)

colormap(jet);
%xlim([0 (128-1)*h]);
%ylim([0 (128-1)*h]);

title('vis=0.1,famp=5.0d-2,uo=0.1');
view(2)

shading interp
colorbar;

%for i = 1:Nt
%plot( xx(i,:), yy(i,:), '.-k','Markersize',16)
%xlim([0 3]); ylim([0 3]);
%pause(0.001)
%end




