#!/bin/bash -f
#a=0
#while [ "$a" == 0 ]; do
	total_mem_free=`free | awk 'FNR==2 {print $4}'`
	rrdtool update /var/Meereen.Comm.Hub/rrd/memfree.rrd N:$total_mem_free
	#sleep 3
#	perl -e 'sleep 300 - time % 300'
#done # hier enden wir nie...

