clear all
close all
mkdir anu_data_files; 

%%----------Tracking the motion of an elastoinertial chain with sinusoidal velocity-------------------%%

%%------------------------Initialisations--------------------------------%%
%%---------------Initialising the box and creating the mesh-------------%%

N = 512; dx = 2*pi/N; dy = 2*pi/N; nt = 10^6; dt = 10^(-4); p = 1; 
x = 0: dx :(2*pi*(1-1/N));
y = 0: dx :(2*pi*(1-1/N));
[X,Y] = meshgrid(x,y);

%%--------------------Initialising the particle positions,velocities---------------%%

x0 = 0.0; y0 = 0.0; ri = 0.0001; r0 = 0.2; rm = 2;Np=20;
tauE = 100; tauP = 0.5;

for i = 1:Np
    xp(:,i) = x0 +(i*ri);
    yp(:,i) = y0 +(i*ri);
end
vx(:,Np) = 0;
vy(:,Np) = 0;

%%--------------------Initialising the spring-length---------------%%

for j = 1: Np-1
    delX = xp(j+1) - xp(j);
    delY = yp(j+1) - yp(j);
    f(j) = (1 - (delX^2 + delY^2)/rm^2)^(-1);
end

ux = 0.5*kron(sin(0:p*dx:2*p*pi*(1-1/N)),sin(0:p*dx:2*p*pi*(1-1/N)).');  
uy = 0.5*kron(sin(0:p*dx:2*p*pi*(1-1/N)),sin(0:p*dx:2*p*pi*(1-1/N)).');   

omega = (circshift(uy,-1,2)-circshift(uy,1,2))/(2*dx)-(circshift(ux,-1,1)-circshift(ux,1,1))/(2*dx);

%%---------------Writing intial conditions as output files----------------%%

fid1 = fopen('anu_data_files/ux0.out','w'); fid2 = fopen('anu_data_files/uy0.out','w'); fid3 = fopen('anu_data_files/omega0.out','w');
for n=1:N
    fprintf(fid1,'%d\t',ux(n,:));
    fprintf(fid1,'\n');
    fprintf(fid2,'%d\t',uy(n,:));
    fprintf(fid2,'\n');
    fprintf(fid3,'%d\t',omega(n,:));
    fprintf(fid3,'\n');
end
fclose('all');

%%-----------------------Saving initial particle locations---------------%%

fid1 = fopen('anu_data_files/xp0.out','w'); fid2 = fopen('anu_data_files/yp0.out','w'); 
fid3 = fopen('anu_data_files/f0.out','w');
fprintf(fid1,'%d\t',xp); fprintf(fid2,'%d\t',yp); fprintf(fid3,'%d\t',f(j));   
fclose('all');

%%-----------------------------time evolution----------------------------%%

for it = 1:nt
    
    %%---------------Extracting coordinates of grid points---------------%%
    
    x1 = floor(mod(xp/dx,N)); y1 = floor(mod(yp/dx,N)); x2 = x1+1; y2 = y1+1;
    
    x1y1 = sub2ind(size(ux),mod(x1,N)+1,mod(y1,N)+1); 
    x1y2 = sub2ind(size(ux),mod(x1,N)+1,mod(y2,N)+1);   %% obtaining indices of four surrounding grid points
    x2y1 = sub2ind(size(ux),mod(x2,N)+1,mod(y1,N)+1); 
    x2y2 = sub2ind(size(ux),mod(x2,N)+1,mod(y2,N)+1);
    
    x1 = x1*dx; x2=x2*dx; y1=y1*dx; y2=y2*dx;

    %%-----------------Interpolation to off-grid locations---------------%%
    uxp = (ux(x1y1).*(x2-xp).*(y2-yp) + ux(x2y1).*(xp-x1).*(y2-yp) + ux(x1y2).*(x2-xp).*(yp-y1) + ux(x2y2).*(xp-x1).*(yp-y1))/(dx^2) ;
    uyp = (uy(x1y1).*(x2-xp).*(y2-yp) + uy(x2y1).*(xp-x1).*(y2-yp) + uy(x1y2).*(x2-xp).*(yp-y1) + uy(x2y2).*(xp-x1).*(yp-y1))/(dx^2) ; 

    for ip = 1:Np
          
            if(ip==1)
                
                ax = ((uxp -vx(ip))+(f(ip)/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;
                ay = ((uyp -vy(ip))+(f(ip)/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1))/tauP;  %calculated for the inertial particle
                vx = vx(ip) + dt*ax;
                vy = vy(ip) + dt*ay;
           
            elseif(ip==Np)
                
                vx = uxp - (f(ip-1)/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1);
                vx = uyp - (f(ip-1)/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1);
                
               
            else
                vx = uxp + ((f(ip)-f(ip-1))/tauE) * delX + sqrt(r0^2/(2*tauE)) * randn(1,1);
                vy = uyp + ((f(ip)-f(ip-1))/tauE) * delY + sqrt(r0^2/(2*tauE)) * randn(1,1);
            end
    end
    %%----------------------Particle Evolution---------------------------%%
    xp = xp + uxp*dt;  
    yp = yp + uyp*dt;
  
    fid3 = fopen(sprintf('anu_data_files/fj%d.out',it/1000),'w');

    for j = 1: Np-1
    delX = xp(j+1) - xp(j);
    delY = yp(j+1) - yp(j);
    f(j) = (1 - (delX^2 + delY^2)/rm^2)^(-1);
        if(mod(it,1000)==0)
            fprintf(fid3,'%d\t',f(j));
        end
    %f
    end 
    %%-------------writing output after every 1k iterations------------%%
    if(mod(it,1000)==0)
        
        fid1 = fopen(sprintf('anu_data_files/xp%d.out',it/1000),'w'); 
        fid2 = fopen(sprintf('anu_data_files/yp%d.out',it/1000),'w');    
        

        fprintf(fid1,'%d\t',mod(xp(:),2*pi)); 
        fprintf(fid2,'%d\t',mod(yp(:),2*pi));
        %fprintf(fid3,'%d\t'f(j))
        fclose('all');
    end
end

%%---------------------------------plotting------------------------------%%
fig = figure();
 set(fig,'color','white')
 set (gca, 'fontsize',18)
 xlabel('x')
 ylabel('y')
% zlabel('z')
surf(X,Y,ux,uy)
%quiver(X,Y,ux,uy)
hold on

for i = 1:Np
plot( xp(:,i), yp(:,i), '.-k','Markersize',16)
xlim([0 2*pi*(1-1/N)]); ylim([0 2*pi*(1-1/N)]);
pause(0.001)
end

hold off
   
    

