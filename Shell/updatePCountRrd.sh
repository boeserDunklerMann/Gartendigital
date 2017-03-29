#!/bin/bash -f
a=0
while [ "$a" == 0 ]; do
	pcount=`ps -e | awk 'END {print NR-1}'`
	rrdtool update /var/Meereen.Comm.Hub/rrd/pcount.rrd N:$pcount
	sleep 1
done # hier enden wir nie...

