#!/bin/bash
# CPU-Temperatur auslesen, formatieren und auf eine 
# Nachkommastelle kuerzen, sekuendlich
a=0
while [ "$a"==0 ] ; do
    TEMP=$(echo "scale=1;$(cat /sys/class/thermal/thermal_zone0/temp ) / 1000 "|bc -l)
    rrdtool update /var/Meereen.Comm.Hub/rrd/soctemp.rrd N:$TEMP
    sleep 1
done;

