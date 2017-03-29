#!/bin/bash
# Meereen
# update networktraffic-rrd-db, minutly, called by cron
# 29.03.2017
rx=` ifconfig eth0 | awk 'FNR==8 {print $3}' | tr '(' ' '`
tx=` ifconfig eth0 | awk 'FNR==8 {print $7}' | tr '(' ' '`
tot=`echo "$rx+$tx" | bc`
rrdtool update /var/Meereen.Comm.Hub/rrd/networkrxtx.rrd N:$tot
