#!/bin/bash
# Meereen
# update networktraffic-rrd-db, minutly, called by cron
# 29.03.2017
tot=`echo "scale=1;($(cat /sys/class/net/eth0/statistics/tx_bytes)+$(cat /sys/class/net/eth0/statistics/rx_bytes))/1024" | bc -l`
echo $tot
rrdtool update /var/Meereen.Comm.Hub/rrd/networkrxtx.rrd N:$tot
