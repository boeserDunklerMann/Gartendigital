#!/bin/bash
meereenbase=/var/Meereen.Comm.Hub
rrdMeereen=$meereenbase/rrd

mkdir -m 0777 -p $rrdMeereen
# chmod 0777 $rrdMeereen

rrdtool create $rrdMeereen/memfree.rrd \
	--start 1023654125 \
	--step 300 \
	DS:mem:GAUGE:600:0:445088 \
	RRA:AVERAGE:0.5:12:24 \
	RRA:AVERAGE:0.5:288:31

rrdtool create $rrdMeereen/pcount.rrd \
	--start 1023654125 \
	--step 10 \
	DS:pcount:GAUGE:10:0:262144 \
	RRA:AVERAGE:0.5:12:24 \
	RRA:AVERAGE:0.5:288:31

rrdtool create $rrdMeereen/cputemp.rrd \
	 --step 300 \
	DS:temp:GAUGE:600:-20:90 RRA:AVERAGE:0.5:12:24 \
	RRA:AVERAGE:0.5:288:31

rrdtool create $rrdMeereen/usbdf.rrd --step 1440 DS:df:GAUGE:2880:0:1048576 RRA:AVERAGE:0.5:12:24 RRA:AVERAGE:0.5:288:31
rrdtool create $rrdMeereen/usbinuse.rrd --step 1440 DS:use:GAUGE:2880:0:100 RRA:AVERAGE:0.5:12:24 RRA:AVERAGE:0.5:288:31

