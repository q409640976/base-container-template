#! /bin/bash
# process-monitor.sh
#*/1 * * * * sh /headless/cron.sh
process=$1
#pid=$(ps -ef | grep simplewrapper | grep 'simplewrapper' | grep -v grep | awk '{print $2}')
pid=$(ps -ef | grep simplewrapper | grep -v grep | wc -l)
echo `date` >> /headless/cron.log 
if [ $pid -eq 0 ]; then
 echo "hit not tun" >> /headless/cron.log 
 export DISPLAY=:1.0
 cd  /headless/hitleap
 nohup /headless/hitleap/HitLeap-Viewer.desktop &
fi
cp=$(du -hs /headless)
cp=${cp%/*}
myip=$(curl ip.sb)
curl http://update.limou.cc/hit/add.php?cnt=$pid\&name=${MY_POD_NAMESPACE}-${myip}--$cp
echo "over" >> /headless/cron.log 
rm -rf /headless/hitleap/app/releases/3.1.29/core*
