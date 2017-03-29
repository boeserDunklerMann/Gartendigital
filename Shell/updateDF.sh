#!/bin/bash
dffree=`df | grep sda1 | awk '{print $4}'`
dfinuse=`df | grep sda1 | awk '{print $5}' | tr '%' ' '`

rrdtool update /var/Meereen.Comm.Hub/rrd/usbdf.rrd N:$dffree
rrdtool update /var/Meereen.Comm.Hub/rrd/usbinuse.rrd N:$dfinuse

