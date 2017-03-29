#!/bin/bash
# CPU-Temperatur auslesen, formatieren und auf eine 
# Nachkommastelle kerzen
TEMP=$(echo "scale=1;$(cat /sys/class/thermal/thermal_zone0/temp ) / 1000 "|bc -l)

echo $TEMP

rrdtool update /var/Meereen.Comm.Hub/rrd/cputemp.rrd N:$TEMP

