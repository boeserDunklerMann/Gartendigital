#!/bin/bash
dffree=`df -B K --out=avail /dev/sda1 | awk 'FNR==2 {print $1}' | tr 'K' ' '`

rrdtool update /var/Meereen.Comm.Hub/rrd/usbdf.rrd N:$dffree

