mkdir data_files; 

%%-----------------------------------------------------------------------%%
%%----------Particle tracking with sinusoidal velocity-------------------%%

%%------------------------Initialisations--------------------------------%%
N = 512; dx = 2*pi/N; nt = 10^6; dt = 10^(-4); p = 1; xp = 2*pi*rand(1,20); yp = 2*pi*rand(1,20);

ux = 0.5*kron(sin(0:p*dx:2*p*pi*(1-1/N)),sin(0:p*dx:2*p*pi*(1-1/N)).');   %% kron computes the direct product of to matrices
uy = 0.5*kron(sin(0:p*dx:2*p*pi*(1-1/N)),sin(0:p*dx:2*p*pi*(1-1/N)).');   %% Direct product of Nx1 and 1XN arrays gives a NxN matrix: N is the no. of grid points

omega = (circshift(uy,-1,2)-circshift(uy,1,2))/(2*dx)-(circshift(ux,-1,1)-circshift(ux,1,1))/(2*dx);   %%circshift is used to shift columns to right/left(1/-1)
%%-----------------------------------------------------------------------%%

%%---------------Writing intial conditions as output files----------------%%
fid1 = fopen('data_files/ux0.out','w'); fid2 = fopen('data_files/uy0.out','w'); fid3 = fopen('data_files/omega0.out','w');
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
fid1 = fopen('data_files/xp0.out','w'); fid2 = fopen('data_files/yp0.out','w');       
fprintf(fid1,'%d\t',xp); fprintf(fid2,'%d\t',yp);    
fclose('all');
%%-----------------------------------------------------------------------%%

%%----------------------Time marching--------------------------%%

for i = 1:nt
    
    %%---------------Extracting coordinates of grid points---------------%%
    
    x1 = floor(mod(xp/dx,N)); y1 = floor(mod(yp/dx,N)); x2 = x1+1; y2 = y1+1;
    
    x1y1 = sub2ind(size(ux),mod(x1,N)+1,mod(y1,N)+1); 
    x1y2 = sub2ind(size(ux),mod(x1,N)+1,mod(y2,N)+1);   %% obtaining indices of four surrounding grid points
    x2y1 = sub2ind(size(ux),mod(x2,N)+1,mod(y1,N)+1); 
    x2y2 = sub2ind(size(ux),mod(x2,N)+1,mod(y2,N)+1);
    
    x1 = x1*dx; x2=x2*dx; y1=y1*dx; y2=y2*dx;

    %%-----------------Interpolation to off-grid locations---------------%%
    uxp = [ux(x1y1).*(x2-xp).*(y2-yp) + ux(x2y1).*(xp-x1).*(y2-yp) + ux(x1y2).*(x2-xp).*(yp-y1) + ux(x2y2).*(xp-x1).*(yp-y1)]/(dx^2) ;
    uyp = [uy(x1y1).*(x2-xp).*(y2-yp) + uy(x2y1).*(xp-x1).*(y2-yp) + uy(x1y2).*(x2-xp).*(yp-y1) + uy(x2y2).*(xp-x1).*(yp-y1)]/(dx^2) ; 

    %%----------------------Particle Evolution---------------------------%%
    xp = xp + uxp*dt;  yp = yp + uyp*dt;
    
    %%-------------writing output after every 1k iterations------------%%
    if(mod(i,1000)==0)
        
        fid1 = fopen(sprintf('data_files/xp%d.out',i/1000),'w'); fid2 = fopen(sprintf('data_files/yp%d.out',i/1000),'w');       
        fprintf(fid1,'%d\t',mod(xp(:),2*pi)); fprintf(fid2,'%d\t',mod(yp(:),2*pi));    %%Saving after folding particle locations into the box
        fclose('all');
    end
end