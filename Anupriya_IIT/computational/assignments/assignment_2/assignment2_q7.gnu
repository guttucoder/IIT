set title "Fig 1. (Q.7)"
set size 1,1
set xlabel "X"
set ylabel "Y"
set border lw 1.2
f(x)=((a*x*x)+(b*x)+c)
fit f(x) "data.dat" u 1:2 via a,b,c
set key default
set key box
set key at 68,140
pl "data.dat" w lp ps 1 pt 7 lc 2 lw 2 title "From data",f(x) lw 2 lc 4 title "Best fit curve with fit parameters : a= -0.170914; b= 14.03; c= -12.9342"
repl 