#!/bin/bash
# Meereen
# update freeswap-rrd-db, minutly, called by cron
# 29.03.2017
swapfree=`free -b | awk 'FNR==4 {print $4}'`
rrdtool update /var/Meereen.Comm.Hub/rrd/swapfree.rrd N:$swapfree