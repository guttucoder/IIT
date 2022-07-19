clear all; 
close all;
%a=2.5;
%y = 1:a:;
%xx(10:10);
%xx(1,:)=y;
%y;
%xx;
%ri = 0.1
%Np = 10;
%for i = 0: Np-1
 %   x(1, :) = [1+i*ri];
  %  disp (x);
  %  xx = x.';
   % disp(xx);
%end

Np=6; f = 1.0; kk = 1.0;
Nt=10; ri=0.1; rm=0.5;
for it= 1:Nt
    for ip = 1:Np
       xx(it,ip) = 1 +(ip*ri); yy(it,ip) = 1 +(ip*ri);  %tried to write a row matrix ,checked all methods given online, but everytime ended with a column matrix.
    end
end
vx(1:Nt,1:Np) = 0.0; vy(1:Nt,1:Np) = 0.0;


for it = 1:Nt
    for j = 1: Np-1
        delX = xx(it,j+1) - xx(it,j); %error shows : "Index in position 2 exceeds array bounds (must not exceed 1)."
        delY = yy(it,j+1) - yy(it,j);
        fj(it,j) = (1 - (delX^2 + delY^2)/rm^2)^(-1);
       % fj
    end
end
fj;
for it =1: Nt-1   
        for ip = 1:Np
          ux = 0.5*f*sin(kk*xx(it,ip))*cos(kk*yy(it,ip)); 
          uy = -0.5*f*cos(kk*xx(it,ip))*sin(kk*yy(it,ip));

