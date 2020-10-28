set title "Fig.2"
set multiplot
set size 1,1
set log y
set xlabel "X"
set ylabel "log Y"
set border lw 1.2
plot "data_2_dp.dat" u 1:2 w lp ps 1 pt 7 lt 1 lc 5 lw 1.5 title "from data 2"
repl "data_3_dp.dat" u 1:2 w lp ps 1 pt 7 lt 1 lc 7 lw 1.5 title "from data 3"
set size 0.45, 0.45
set origin 0.5, 0.2
set title "Fig.1"
f(x)=exp((a*x)+b)
g(x)=exp((c*x)+d)
fit f(x) "data_1_dp.dat" u 1:2:5 via a, b
fit g(x) "data_1_dp.dat" u 1:3:6 via c, d
pl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on Y",f(x) lw 2 title "Best fit curve (x vs y)", "data_1_dp.dat" u 1:3:6 w err lw 2 title "error bar on Z",g(x) lw 2 title "Best fit curve (x vs z)"
unset multiplot

