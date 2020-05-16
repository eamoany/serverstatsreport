#!/bin/bash 
date=$(date +"%d-%m-%Y")

#source usage and html files
source /root/scripts/stats.sh

sh /root/scripts/stats.sh > /var/www/html/serverstats/index.html        

#Exit status
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
echo "$date cron executed successfully" >> /var/log/serverstatsreport.log
else
echo "$date cron didnt execute successfully" >> /var/log/serverstatsreport.log
fi

