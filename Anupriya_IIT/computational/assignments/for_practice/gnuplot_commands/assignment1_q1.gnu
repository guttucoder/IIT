Last login: Fri Sep 25 13:45:51 on ttys001
anupriya@KUSHALs-MacBook-Air ~ % cd Desktop 
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
gnuplot> fit f(x) "data_1_dp.dat" u 1:2:5 via a, b
         warning: 
	> Implied independent variable y not found in fit function.
	> Assuming version 4 syntax with zerror in column 3 but no zerror keyword.

iter      chisq       delta/lim  lambda   a             b            
   0 2.3464819235e+03   0.00e+00  1.18e+02    1.000000e+00   1.000000e+00
   1 3.7362571126e+02  -5.28e+05  1.18e+01    8.924277e-01   9.867294e-01
   2 6.7298332336e+01  -4.55e+05  1.18e+00    7.840715e-01   9.816303e-01
   3 3.1112595122e+01  -1.16e+05  1.18e-01    6.389061e-01   1.440003e+00
   * 1.2026673432e+05   1.00e+05  1.18e+00   -1.318578e+00   1.669927e+01
   4 2.8026720427e+01  -1.10e+04  1.18e-01    5.472957e-01   1.784713e+00
   * 5.5679499439e+05   1.00e+05  1.18e+00   -1.476683e+00   1.785507e+01
   5 2.7700944160e+01  -1.18e+03  1.18e-01    4.990206e-01   2.090793e+00
   * 1.2982302135e+06   1.00e+05  1.18e+00   -1.554235e+00   1.846342e+01
   6 2.7381458064e+01  -1.17e+03  1.18e-01    4.596748e-01   2.414149e+00
   * 2.3989298808e+06   1.00e+05  1.18e+00   -1.610257e+00   1.890198e+01
   7 2.6977182618e+01  -1.50e+03  1.18e-01    4.157496e-01   2.775903e+00
   * 3.4735949308e+06   1.00e+05  1.18e+00   -1.645007e+00   1.916781e+01
   8 2.6449507115e+01  -2.00e+03  1.18e-01    3.659766e-01   3.186325e+00
   * 3.4869955854e+06   1.00e+05  1.18e+00   -1.648004e+00   1.917670e+01
   9 2.5733256463e+01  -2.78e+03  1.18e-01    3.085953e-01   3.660030e+00
   * 2.0841818983e+06   1.00e+05  1.18e+00   -1.605878e+00   1.882155e+01
  10 2.4710951245e+01  -4.14e+03  1.18e-01    2.409852e-01   4.218612e+00
   * 6.3066287365e+05   1.00e+05  1.18e+00   -1.503563e+00   1.798229e+01
  11 2.3154326804e+01  -6.72e+03  1.18e-01    1.591154e-01   4.894886e+00
   * 8.6117024684e+04   1.00e+05  1.18e+00   -1.328433e+00   1.655968e+01
  12 2.0587152889e+01  -1.25e+04  1.18e-01    5.671819e-02   5.738594e+00
   * 5.5236960292e+03   9.96e+04  1.18e+00   -1.080962e+00   1.456196e+01
  13 1.6023766632e+01  -2.85e+04  1.18e-01   -7.493883e-02   6.814279e+00
   * 2.0925393483e+02   9.23e+04  1.18e+00   -7.967791e-01   1.228320e+01
  14 8.3947762334e+00  -9.09e+04  1.18e-01   -2.389676e-01   8.122110e+00
  15 4.8109201452e+00  -7.45e+04  1.18e-02   -5.715578e-01   1.049828e+01
  16 6.1695265925e-01  -6.80e+05  1.18e-03   -5.103670e-01   9.992543e+00
  17 5.1681239636e-01  -1.94e+04  1.18e-04   -4.924709e-01   9.869771e+00
  18 5.1650116729e-01  -6.03e+01  1.18e-05   -4.912684e-01   9.862080e+00
  19 5.1650078026e-01  -7.49e-02  1.18e-06   -4.912257e-01   9.861827e+00
iter      chisq       delta/lim  lambda   a             b            

After 19 iterations the fit converged.
final sum of squares of residuals : 0.516501
rel. change during last iteration : -7.49341e-07

degrees of freedom    (FIT_NDF)                        : 4
rms of residuals      (FIT_STDFIT) = sqrt(WSSR/ndf)    : 0.35934
variance of residuals (reduced chisquare) = WSSR/ndf   : 0.129125
p-value of the Chisq distribution (FIT_P)              : 0.971875

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
a               = -0.491226        +/- 0.03397      (6.915%)
b               = 9.86183          +/- 0.1726       (1.75%)

correlation matrix of the fit parameters:
                a      b      
a               1.000 
b              -0.938  1.000 
gnuplot> repl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on Y",f(x) lw 2 title "Best fit curve (x vs y)"
         ^
         no previous plot

gnuplot> pl "data_1_dp.dat" u 1:2:5 w err lw 2 title "error bar on Y",f(x) lw 2 title "Best fit curve (x vs y)"
qt.qpa.fonts: Populating font family aliases took 316 ms. Replace uses of missing font family "Sans" with one that exists to avoid this cost. 

Warning: slow font initialization
gnuplot> set log y
gnuplot> set size square
gnuplot> set xlabel "X"
gnuplot> set ylabel "log Y"
gnuplot> set border lw 1.5
gnuplot> repl
gnuplot> g(x)=exp((c*x)+d)
gnuplot> fit g(x) "data_1_dp.dat" u 1:3:6 via c, d
         warning: 
	> Implied independent variable y not found in fit function.
	> Assuming version 4 syntax with zerror in column 3 but no zerror keyword.

iter      chisq       delta/lim  lambda   c             d            
   0 3.6734399863e+04   0.00e+00  4.53e+02    1.000000e+00   1.000000e+00
   1 5.8116330058e+03  -5.32e+05  4.53e+01    8.882478e-01   9.860374e-01
   2 8.4277050516e+02  -5.90e+05  4.53e+00    7.698498e-01   9.771252e-01
   3 1.9066892301e+02  -3.42e+05  4.53e-01    6.094381e-01   1.365485e+00
   4 3.0247395279e+01  -5.30e+05  4.53e-02   -1.779244e-01   6.871184e+00
   5 4.9885861471e+00  -5.06e+05  4.53e-03   -3.438490e-01   7.506117e+00
   6 2.9564872301e+00  -6.87e+04  4.53e-04   -4.118249e-01   7.759208e+00
   7 2.8984543175e+00  -2.00e+03  4.53e-05   -4.245641e-01   7.805765e+00
   8 2.8974391845e+00  -3.50e+01  4.53e-06   -4.263206e-01   7.812670e+00
   9 2.8974252054e+00  -4.82e-01  4.53e-07   -4.265495e-01   7.813590e+00
iter      chisq       delta/lim  lambda   c             d            

After 9 iterations the fit converged.
final sum of squares of residuals : 2.89743
rel. change during last iteration : -4.82468e-06

degrees of freedom    (FIT_NDF)                        : 4
rms of residuals      (FIT_STDFIT) = sqrt(WSSR/ndf)    : 0.851091
variance of residuals (reduced chisquare) = WSSR/ndf   : 0.724356
p-value of the Chisq distribution (FIT_P)              : 0.575135

Final set of parameters            Asymptotic Standard Error
=======================            ==========================
c               = -0.426549        +/- 0.04929      (11.56%)
d               = 7.81359          +/- 0.2046       (2.619%)

correlation matrix of the fit parameters:
                c      d      
c               1.000 
d              -0.936  1.000 
gnuplot> repl "data_1_dp.dat" u 1:3:6 w err lw 2 title "error bar on Z",g(x) lw 2 title "Best fit curve (x vs z)"
gnuplot> 
