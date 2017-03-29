#!/bin/bash
meereenbase=/var/Meereen.Comm.Hub

rrdtool graph $meereenbase/wwwroot/images/rrd/cputemp.png --start -24h --title "CPU-Temperatur" --vertical-label "Grad Celsius" \
	DEF:cputemperatur=$meereenbase/rrd/cputemp.rrd:temp:AVERAGE LINE1:cputemperatur#ff0000:"CPU-Temperatur" 

rrdtool graph $meereenbase/wwwroot/images/rrd/memfree.png --start -24h --title "freier Speicher (RAM)" --vertical-label "Bytes" \
	DEF:memfree=$meereenbase/rrd/memfree.rrd:mem:AVERAGE AREA:memfree#0000ff:"Memory frei"

rrdtool graph $meereenbase/wwwroot/images/rrd/pcount.png --start -24h --title "Process Count" --vertical-label "Anzahl" \
	DEF:pcount=$meereenbase/rrd/pcount.rrd:pcount:AVERAGE LINE1:pcount#ff0000:"Prozess Anzahl"

rrdtool graph $meereenbase/wwwroot/images/rrd/usbfree.png --start -1w --title "freier Speicher (externe HDD)" --vertical-label "MiBi" \
	DEF:df=$meereenbase/rrd/usbdf.rrd:df:AVERAGE AREA:df#0000ff:"HDD frei"

rrdtool graph $meereenbase/wwwroot/images/rrd/usbinuse.png --start -1w --title "externe Festplatte in Benutzung" --vertical-label "Prozent" \
	DEF:inuse=$meereenbase/rrd/usbinuse.rrd:use:AVERAGE LINE2:inuse#ffff00:"benutzt"


