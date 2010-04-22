set term postscript
#set pointsize 0.5
set pointsize 0.25
set style line 1 lt rgb "black" lw 1 pt 6
set output "lol.ps"
plot "out.ratvrat" using 1:2 with points ls 1
