#!/bin/bash
meereenbase=/var/Meereen.Comm.Hub
imgdest=$meereenbase/wwwroot/images/rrd
rrdsrc=$meereenbase/rrd

rrdtool graph $imgdest/cputemp.png --start -24h --title "SOC-Temperatur" --vertical-label "°C" \
	DEF:cputemperatur=$rrdsrc/soctemp.rrd:temp:AVERAGE LINE1:cputemperatur#ff0000:"SOC-Temperatur" 

rrdtool graph $imgdest/memfree.png --start -24h --title "free RAM" --vertical-label "Bytes" \
	DEF:memfree=$rrdsrc/memfree.rrd:mem:AVERAGE AREA:memfree#0000ff:"free RAM"

rrdtool graph $imgdest/pcount.png --start -24h --title "Process Count" --vertical-label "Anzahl" \
	DEF:pcount=$meereenbase/rrd/pcount.rrd:pcount:AVERAGE LINE1:pcount#ff0000:"Processes"

rrdtool graph $imgdest/usbfree.png --start -1w --title "free HDD" --vertical-label "KiBi" \
	DEF:df=$rrdsrc/usbdf.rrd:df:AVERAGE AREA:df#0000ff:"HDD free"

rrdtool graph $imgdest/networkrxtx.png --start -24h --title="Network action" --vertical-label="KiBi" \
	DEF:net=$rrdsrc/networkrxtx.rrd:net:AVERAGE AREA:net#00ff00:"Network"

rrdtool graph $imgdest/swapfree.png --start -31d --title="free Swap" --vertical-label="Bytes" \
	DEF:swapfree=$rrdsrc/swapfree.rrd:swapfree:AVERAGE AREA:swapfree#0000ff:"free Swap"

rrdtool graph $imgdest/totalfree.png --start -31d --title="Total free" --vertical-label="Bytes" \
	DEF:tfree=$rrdsrc/totalfree.rrd:tfree:AVERAGE AREA:tfree#00ffff:"total free"
