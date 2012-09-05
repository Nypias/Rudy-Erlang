set term postscript eps enhanced color
set output "multi_processes.eps"
set title "Response Time per request - With concurrency - Server multi-threaded"
set xlabel "Request"
set ylabel "Response Time (ms)"
set xrange [0:100]
set yrange [0:70]

set grid y

plot "multi_processes.dat" using 9 smooth sbezier with lines title "multi processes"

