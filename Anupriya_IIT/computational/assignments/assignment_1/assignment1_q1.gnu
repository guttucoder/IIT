set title "Fig.1"
set log y
set size square
set xlabel "X"
set ylabel "log Y"
set border lw 1.5
f(x)=exp((a*x)+b)
fit f(x) "data_1_dp.dat" u 1:2:5 via a, b
pl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on Y",f(x) lw 2 title "Best fit curve (x vs y)"
g(x)=exp((c*x)+d)
fit g(x) "data_1_dp.dat" u 1:3:6 via c, d
repl "data_1_dp.dat" u 1:3:6 w err lw 2 title "error bar on Z",g(x) lw 2 title "Best fit curve (x vs z)"
