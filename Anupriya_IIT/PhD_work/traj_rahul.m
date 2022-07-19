close all; clear all;

mkdir images
n=512; npart=20;
x=(0):2*pi/n:(2*pi-(2*pi/n));
y=(0):2*pi/n:(2*pi-(2*pi/n));
[X,Y]=meshgrid(x,y);


for itime=0:100:1000
    itime
FigH = figure('Position', get(0, 'Screensize'),'visible','off');
%figure;
%trajc=figure('visible','off');
Xp=load(sprintf('data_files/xp%d.out',itime));
Yp=load(sprintf('data_files/yp%d.out',itime));

vort=load('data_files/omega0.out'); rms = sqrt(mean(mean(vort.^2)));
pcolor(X,Y,vort);shading('interp')
colormap('summer')
colorbar;
caxis([-1 1]);
hold on
for i=1:npart
plot(Yp(1,i),Xp(1,i),'or','MarkerFaceColor','r','MarkerSize',6)
hold on
end
c1=colorbar;
set(c1,'TickLabelInterpreter','latex');
pbaspect([1,1,1])
axis([0 2*pi-(2*pi/n) 0 2*pi-(2*pi/n)])
h=gca; h.FontSize = 24; h.TickLabelInterpreter = 'Latex';
h.LineWidth = 2;
fclose('all');
F = getframe(FigH);

imwrite(F.cdata, sprintf('images/traj%d.png',itime),'png')
end