set term postscript eps enhanced color
set output "with_concurrency.eps"
set title "Response Time per request - With concurrency"
set xlabel "Request"
set ylabel "Response Time (ms)"
set xrange [0:100]
set yrange [0:200]

set grid y

plot "with_concurrency.dat" using 9 smooth sbezier with lines title "With concurrency"

