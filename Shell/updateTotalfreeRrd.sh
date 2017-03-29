#!/bin/bash
# Meereen
# update totalfreemem-rrd-db, minutly, called by cron
# 29.03.2017
totfree=`free -b -t | awk 'FNR==5 {print $4}'`
rrdtool update /var/Meereen.Comm.Hub/rrd/totalfree.rrd N:$totfree