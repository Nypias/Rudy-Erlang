set term postscript eps enhanced color
set output "no_concurrency.eps"
set title "Response Time per request - Without concurrency"
set xlabel "Request"
set ylabel "Response Time (ms)"
set xrange [0:100]
set yrange [0:70]

set grid y

plot "no_concurrency.dat" using 9 smooth sbezier with lines title "Without concurrency"

