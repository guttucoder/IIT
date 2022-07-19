z = load('outfile.out');
t = z(:,1);
x = z(:,2);
y = z(:,3);
plot(x,y)
title('Trajectory of a particle')
xlabel('X')
ylabel('Y')
%wl = 2*pi
%axis([0,wl,0,wl]);