#!/system/bin/sh
# 此脚本将在late_start service 模式执行
# 如果您需要知道此脚本和模块的放置位置，请使用$MODDIR
MODDIR=${0%/*}

export PATH=/system/bin:$PATH
export sd=/data/media/0
FileClear_logname=FileClear_zw_09-01_20:26:30.txt
restart_time=`date +"%Y-%m-%d %T"`
nowtime=`date +"%m-%d_%T"`
sleep 10s

# 执行startclear.sh;因call_miuicleanmaster-for-zw_fileclear.sh是开机25s后执行，所以要放在前面
test ! -f /data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh && su -c "sh $MODDIR/startclear.sh" || su -c "sh $MODDIR/startclear.sh -n"

# 安装crontabs服务
#test $(getprop ro.build.version.release) -ge 11 && crond_2="/dev/*/.magisk/busybox/crond" || crond_2="/sbin/.magisk/busybox/crond"
crond_2="$(magisk --path)/.magisk/busybox/crond"
magisk_path=$(magisk --path)/.magisk
mount|grep "ro,"|grep -v "$magisk_path/"|awk -F'[ ,]' '{print $1,$3}'|while read a b
do
mount -o rw,remount $a $b &>/dev/null
done
[ ! -d /var/spool/cron/crontabs ] && mkdir -p /var/spool/cron/crontabs
cp -f $MODDIR/crontabs.txt /var/spool/cron/crontabs/root
chmod -R 0777 /var/spool/cron/crontabs/root
test -z $(pgrep crond) && $crond_2 start
sleep 10s

# 写入日志
rm -rf $sd/adzw* &>/dev/null
crond_process_status() {
crond_ps_1=`/system/bin/ps -ef | grep -v grep | grep crond | awk '{print "Crontab执行者:"$1,"进程ID:"$2,"CPU:"$4"% 启动时间:"$5,"运行时长:"$7,"命令CMD:"$8}'`
}
FileClear_temp_logname=`ls -lt $sd | grep "FileClear_zw*" | sed -n "1p" | awk '{print $NF}'`
if [ -n "$FileClear_temp_logname" ]; then
  FileClear_temp_1=`grep "FileClear_for_ZW" $sd/$FileClear_temp_logname`
  if [ -n "$FileClear_temp_1" ]; then
    sed -i "7a\   ** 手机重启成功：$restart_time **" $sd/$FileClear_temp_logname
    sleep 60s
    crond_process_status
    sed -i "8a\  $crond_ps_1" $sd/$FileClear_temp_logname
  else
    sed -i "1i\   ** 手机重启成功：$restart_time **" $sd/$FileClear_temp_logname
    sleep 60s
    crond_process_status
    sed -i "2i\  $crond_ps_1" $sd/$FileClear_temp_logname
  fi
else
  echo "   ** 手机重启成功：$restart_time **" >$sd/$FileClear_logname
  sleep 60s
  crond_process_status
  echo "  $crond_ps_1" >>$sd/$FileClear_logname
fi

