set title "iteration step versus the approximate solution"
set size square
set xlabel "iteration step"
set ylabel "approximate solution"
set border lw 1.2
pl "code_output.dat" u 1:2  w lp ps 1 pt 7 lc 2 lw 1.5 title "for initial guess: 3.0"
