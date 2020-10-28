gnuplot> repl "data_1_dp.dat" u 1:2:5 w err title "error bar on y", f(x) title "Bet fit curve"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> repl "data_1_dp.dat" u 1:2:5 w err title "error bar on y", f(x) title "Bet fit curve"
gnuplot> pl "data_1_dp.dat" u 1:2:5 w err title "error bar on y", f(x) title "Bet fit curve"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on y", f(x) lw 2 title "Bet fit curve"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot> repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on y", f(x) lw 2 title "Bet fit curve (x vs y)"
gnuplot> repl "data_1_dp.dat" u 1:3 w lp ps 1 pt 7 lc 7 lw 2 title "x vs z"
gnuplot> repl "data_1_dp.dat" u 1:2:6 w err lw 2 title "error bar on z", f(x) lw 2 title "Bet fit curve (x vs z)"
gnuplot> ^C
gnuplot> pl "data_1_dp.dat" u 1:3:6 w err lw 2 title "error bar on z", f(x) lw 2 title "Bet fit curve (x vs z)"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> fit f(x) "data_1_dp.dat" u 1:2 via a,b
iter      chisq       delta/lim  lambda   a             b            
   0 1.7976557152e+06   0.00e+00  3.46e+04   -7.088677e-01   1.059630e+01
   * 1.7976557163e+06   6.05e-05  3.46e+05   -7.088685e-01   1.059631e+01
   1 1.7976557150e+06  -9.30e-06  3.46e+04   -7.088677e-01   1.059630e+01
iter      chisq       delta/lim  lambda   a             b            

After 1 iterations the fit converged.
final sum of squares of residuals : 1.79766e+06
rel. change during last iteration : -9.30327e-11

degrees of freedom    (FIT_NDF)                        : 4
rms of residuals      (FIT_STDFIT) = sqrt(WSSR/ndf)    : 670.383
variance of residuals (reduced chisquare) = WSSR/ndf   : 449414

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = -0.708868        +/- 0.09479      (13.37%)
b               = 10.5963          +/- 0.2263       (2.136%)

correlation matrix of the fit parameters:
                a      b      
a               1.000 
b              -0.964  1.000 
gnuplot>  repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on y", f(x) lw 2 title "Bet fit curve (x vs y)"
gnuplot> pl "data_1_dp.dat" u 1:3 w lp ps 1 pt 7 lc 1 lw 2 title "x vs z"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> fit f(x) "data_1_dp.dat" u 1:2 via a,b
iter      chisq       delta/lim  lambda   a             b            
   0 1.7976557150e+06   0.00e+00  3.46e+04   -7.088677e-01   1.059630e+01
   * 1.7976557163e+06   7.08e-05  3.46e+05   -7.088685e-01   1.059631e+01
   1 1.7976557149e+06  -7.29e-06  3.46e+04   -7.088677e-01   1.059630e+01
iter      chisq       delta/lim  lambda   a             b            

After 1 iterations the fit converged.
final sum of squares of residuals : 1.79766e+06
rel. change during last iteration : -7.29443e-11

degrees of freedom    (FIT_NDF)                        : 4
rms of residuals      (FIT_STDFIT) = sqrt(WSSR/ndf)    : 670.383
variance of residuals (reduced chisquare) = WSSR/ndf   : 449414

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = -0.708868        +/- 0.09479      (13.37%)
b               = 10.5963          +/- 0.2263       (2.136%)

correlation matrix of the fit parameters:
                a      b      
a               1.000 
b              -0.964  1.000 
gnuplot>  repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on y", f(x) lw 2 title "Bet fit curve (x vs y)"
gnuplot> repl "data_1_dp.dat" u 1:3 w lp ps 1 pt 7 lc 1 lw 2 title "x vs z"
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> fit f(x) "data_1_dp.dat" u 1:3 via a,b
iter      chisq       delta/lim  lambda   a             b            
   0 9.2895790147e+07   0.00e+00  3.46e+04   -7.088677e-01   1.059630e+01
   1 1.2549467751e+07  -6.40e+05  3.46e+03   -7.163124e-01   9.818392e+00
   2 1.0809745757e+06  -1.06e+06  3.46e+02   -7.079623e-01   9.102064e+00
   3 7.2655224737e+04  -1.39e+06  3.46e+01   -6.286512e-01   8.516615e+00
   4 3.2431731502e+04  -1.24e+05  3.46e+00   -5.661083e-01   8.259033e+00
   5 3.1876614624e+04  -1.74e+03  3.46e-01   -5.509291e-01   8.213552e+00
   6 3.1863679078e+04  -4.06e+01  3.46e-02   -5.482904e-01   8.206723e+00
   7 3.1863221659e+04  -1.44e+00  3.46e-03   -5.478255e-01   8.205538e+00
   8 3.1863197070e+04  -7.72e-02  3.46e-04   -5.477429e-01   8.205328e+00
iter      chisq       delta/lim  lambda   a             b            

After 8 iterations the fit converged.
final sum of squares of residuals : 31863.2
rel. change during last iteration : -7.71719e-07

degrees of freedom    (FIT_NDF)                        : 4
rms of residuals      (FIT_STDFIT) = sqrt(WSSR/ndf)    : 89.2513
variance of residuals (reduced chisquare) = WSSR/ndf   : 7965.8

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = -0.547743        +/- 0.07255      (13.24%)
b               = 8.20533          +/- 0.1891       (2.304%)

correlation matrix of the fit parameters:
                a      b      
a               1.000 
b              -0.949  1.000 
gnuplot>  repl "data_1_dp.dat" u 1:3:6 w err lw 2 title "error bar on z", f(x) lw 2 title "Bet fit curve (x vs z)"
gnuplot> 

