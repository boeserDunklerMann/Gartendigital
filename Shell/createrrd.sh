#!/bin/bash
# Meereen
# Setup RRD databases
# 29.03.2017

meereenbase=/var/Meereen.Comm.Hub
rrdMeereen=$meereenbase/rrd

mkdir -m 0777 -p $rrdMeereen
# chmod 0777 $rrdMeereen

# RRD database for free memory (in Bytes)
rrdtool create $rrdMeereen/memfree.rrd \
	--step 60 \
	DS:mem:GAUGE:120:0:455770112 \
	RRA:AVERAGE:0.5:60:24

# RRD database for process count
rrdtool create $rrdMeereen/pcount.rrd \
	--step 1 \
	DS:pcount:GAUGE:2:0:262144 \
	RRA:AVERAGE:0.5:60:1440

# RRD database for Chip-Temperature
rrdtool create $rrdMeereen/soctemp.rrd \
	 --step 1 \
	DS:temp:GAUGE:2:-20:90 \
	RRA:AVERAGE:0.5:60:60

# RRD database for free HDD space (in KiBi)
rrdtool create $rrdMeereen/usbdf.rrd \
	--step 3600 \
	DS:df:GAUGE:7200:0:480589524 \
	RRA:AVERAGE:0.5:24:31

# RRD database for Swapfree (in Bytes, since we use a swapfile no swappartition)
rrdtool create $rrdMeereen/swapfree.rrd \
	--step 60 \
	DS:swapfree:GAUGE:120:0:104853504 \
	RRA:AVERAGE:0.5:60:744

# RRD database for Totalfree (in Bytes)
rrdtool create $rrdMeereen/totalfree.rrd \
	--step 60 \
	DS:tfree:GAUGE:120:0:104853504 \
	RRA:AVERAGE:0.5:60:744

# RRD database for network RXTX outside
rrdtool create $rrdMeereen/networkrxtx.rrd \
	--step 60 \
	DS:net:COUNTER:120:0:U \
	RRA:AVERAGE:0.5:60:744
