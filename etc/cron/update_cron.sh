#!/bin/bash
#####
# cron deployment script - will only update if new content is detected
# @author Yuriy M Goldman
# @since 3/2014
#####
DEPLOYMENT_HOME="/opt/rwizflowy/prod"
CRON_PATH="$DEPLOYMENT_HOME/etc/cron"
timestamp=`date '+%Y%m%d%H%M'`
cron_backup="/tmp/rwizflowy.crontab.$timestamp"

crontab -u rwizflowy -l > $cron_backup
cron_diff=$(diff $cron_backup $CRON_PATH/prod.cron)
if [ -n "$cron_diff" ]; then
        echo "New crontab found, deploying"
        crontab -u rwizflowy $CRON_PATH/prod.cron        
else
        echo "No new crontab found, skipping"
        rm -v $cron_backup
fi