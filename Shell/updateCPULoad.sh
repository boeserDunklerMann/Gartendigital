#!/bin/bash
#
# Meereen
#
# update cpuload-rrd-db, secondly, called by init once
# 29.03.2017
meereenbase=/var/Meereen.Comm.Hub
rrdMeereen=$meereenbase/rrd
a=0
while [ "$a"==0 ]; do

    cpuuser=`head -n 1 /proc/stat | awk '{print $2}'`
    cpusystem=`head -n 1 /proc/stat | awk '{print $4}'`
    cpuidle=`head -n 1 /proc/stat | awk '{print $5}'`
    cpuiowait=`head -n 1 /proc/stat | awk '{print $6}'`

    rrdtool update $rrdMeereen/cpuuser.rrd N:$cpuuser
    rrdtool update $rrdMeereen/cpusys.rrd N:$cpusystem
    rrdtool update $rrdMeereen/cpuidle.rrd N:$cpuidle
    rrdtool update $rrdMeereen/cpuiowt.rrd N:$cpuiowait

    sleep 1
done
