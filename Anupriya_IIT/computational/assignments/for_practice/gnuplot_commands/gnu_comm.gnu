Last login: Fri Sep 25 01:34:46 on ttys000
anupriya@KUSHALs-MacBook-Air ~ % cd D
cd: no such file or directory: D
anupriya@KUSHALs-MacBook-Air ~ % cd Desktop/ 
anupriya@KUSHALs-MacBook-Air Desktop % clear



















anupriya@KUSHALs-MacBook-Air Desktop % gnuplot

	G N U P L O T
	Version 5.2 patchlevel 8    last modified 2019-12-01 

	Copyright (C) 1986-1993, 1998, 2004, 2007-2019
	Thomas Williams, Colin Kelley and many others

	gnuplot home:     http://www.gnuplot.info
	faq, bugs, etc:   type "help FAQ"
	immediate help:   type "help"  (plot window: hit 'h')

Terminal type is now 'qt'
gnuplot> f(x)=exp((a*x)+b)
gnuplot> set log y
gnuplot> plot "data_1_dp.dat" u 1:2:5 w err, f(x) title "Best-Fit Curve"
         undefined variable: a

gnuplot> plot "data_1_dp.dat" u 1:2:5 w err, f(x) title "Best-Fit Curve" via a,b
         undefined variable: a

gnuplot> f(x)=exp((a*x)+b)
gnuplot> set log y
gnuplot> fit f(x) "data_1_dp.dat" u 1:2 via a,b
iter      chisq       delta/lim  lambda   a             b            
   0 1.8117431765e+08   0.00e+00  1.90e+04    1.000000e+00   1.000000e+00
   1 1.3202732661e+08  -3.72e+04  1.90e+03    8.941252e-01   9.892141e-01
   2 1.2477650786e+08  -5.81e+03  1.90e+02    7.740118e-01   1.136274e+00
   3 1.6419527979e+07  -6.60e+05  1.90e+01   -4.222369e-01   1.010990e+01
   4 2.8592775751e+06  -4.74e+05  1.90e+00   -5.714441e-01   1.029319e+01
   5 1.8613863627e+06  -5.36e+04  1.90e-01   -6.705111e-01   1.050756e+01
   6 1.8002572942e+06  -3.40e+03  1.90e-02   -7.009096e-01   1.057757e+01
   7 1.7977429579e+06  -1.40e+02  1.90e-03   -7.073847e-01   1.059278e+01
   8 1.7976574695e+06  -4.76e+00  1.90e-04   -7.086321e-01   1.059574e+01
   9 1.7976557157e+06  -9.76e-02  1.90e-05   -7.088676e-01   1.059630e+01
iter      chisq       delta/lim  lambda   a             b            

After 9 iterations the fit converged.
final sum of squares of residuals : 1.79766e+06
rel. change during last iteration : -9.75646e-07

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
gnuplot> pl "data_1_dp.dat" u 1:2:5 w err, f(x) title "bfc"
qt.qpa.fonts: Populating font family aliases took 321 ms. Replace uses of missing font family "Sans" with one that exists to avoid this cost. 

Warning: slow font initialization
gnuplot> pl "data_1_dp.dat" u 1:2:5 w err w lp ps 1 pt 7 lc 5 title "data", f(x) title "bfc"
                                          ^
         duplicated or contradicting arguments in plot options

gnuplot> pl "data_1_dp.dat" u 1:2:5 w lp ps 1 pt 7 lc 5 title "data" w err , f(x) title "bfc"
                                                                     ^
         duplicated or contradicting arguments in plot options

gnuplot>  f(x)=exp((a*x)+b)
gnuplot> pl f(x) via a,b

gnuplot> pl f(x) via a,b
                 ^
         unexpected or unrecognized token

gnuplot> pl f(x) 
gnuplot> f(x)=exp((3*x)+5)
gnuplot> pl f(x)
gnuplot> unset log
gnuplot> pl f(x)
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> fit f(x) "data_1_dp.dat" u 1:2 via a,b
iter      chisq       delta/lim  lambda   a             b            
   0 1.7976557157e+06   0.00e+00  3.46e+04   -7.088676e-01   1.059630e+01
   * 1.7976557162e+06   3.18e-05  3.46e+05   -7.088685e-01   1.059631e+01
   1 1.7976557154e+06  -1.49e-05  3.46e+04   -7.088676e-01   1.059630e+01
iter      chisq       delta/lim  lambda   a             b            

After 1 iterations the fit converged.
final sum of squares of residuals : 1.79766e+06
rel. change during last iteration : -1.49233e-10

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
gnuplot> set y log
             ^
         unrecognized option - see 'help set'.

gnuplot> set log y
gnuplot> pl "data_1_dp.dat" u 1:2:5 w lp ps 1 pt 7 lc 5 title "data" w err , f(x) title "bfc"
                                                                     ^
         duplicated or contradicting arguments in plot options

gnuplot> pl "data_1_dp.dat" u 1:2:5 w lp ps 1 pt 7 lc 5 title "data", w err , f(x) title "bfc"
         undefined variable: w

gnuplot> pl "data_1_dp.dat" u 1:2:5 w err , f(x) title "bfc"
gnuplot> pl "data_1_dp.dat" u 1:2:5 w err lw 2 w lp ps 1 pt 7 lc 5, f(x) title "bfc"
                                               ^
         duplicated or contradicting arguments in plot options

gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 pc 5

gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 pc 5
                                                 ^
         unexpected or unrecognized token

gnuplot> pl "data_1_dp.dat" u 1:2:5 w err lw 2 w lp ps 1 pt 7 lc 5, f(x) title "bfc"
                                               ^
         duplicated or contradicting arguments in plot options

gnuplot> pl "data_1_dp.dat" u 1:2:5  w err , f(x) title "bfc"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 pc 5

gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 pc 5
                                                 ^
         unexpected or unrecognized token

gnuplot> repl "data_1_dp.dat" u 1:2:5  w err , f(x) title "bfc"
gnuplot> unset log
gnuplot> repl "data_1_dp.dat" u 1:2:5  w err , f(x) title "bfc"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 7
gnuplot> pl "data_1_dp.dat" u 1:2:5  w err 
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 7
gnuplot> repl "data_1_dp.dat" u 1:2:5  w err 
gnuplot> set log y
gnuplot> repl
gnuplot> repl "data_1_dp.dat" u 1:2:5  w err , f(x) title "bfc"
gnuplot> pl "data_1_dp.dat" title "x vs y" u 1:2 w lp ps 1 pt 7 lc 5

gnuplot> pl "data_1_dp.dat" title "x vs y" u 1:2 w lp ps 1 pt 7 lc 5
                                           ^
         unexpected or unrecognized token

gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 5 title "x vs y"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot> repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "errorbar on y"
gnuplot> pl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on y"
gnuplot> pl "data_1_dp.dat" u 1:2 w lp ps 1 pt 7 lc 4 lw 2 title "x vs y"
gnuplot> repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on y"
gnuplot>  f(x)=exp((a*x)+b)
gnuplot> fit f(x) "data_1_dp.dat" u 1:2 via a,b
iter      chisq       delta/lim  lambda   a             b            
   0 1.7976557154e+06   0.00e+00  3.46e+04   -7.088676e-01   1.059630e+01
   * 1.7976557162e+06   4.77e-05  3.46e+05   -7.088685e-01   1.059631e+01
   1 1.7976557152e+06  -1.18e-05  3.46e+04   -7.088677e-01   1.059630e+01
iter      chisq       delta/lim  lambda   a             b            

After 1 iterations the fit converged.
final sum of squares of residuals : 1.79766e+06
rel. change during last iteration : -1.18072e-10

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
gnuplot> plot "cavendish.data" title "" with yerrorbars, theta(x) title "Best-Fit Curve"
         warning: Cannot find or open file "cavendish.data"
         undefined function: theta

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
