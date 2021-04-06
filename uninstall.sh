# 该脚本将在卸载模块期间执行，您可以编写自定义卸载规则
MODDIR=${0%/*}
sd=/data/media/0

# 卸载Crontabs服务
mount|grep "ro,"|grep -v "/sbin/.magisk/"|gawk -F'[ ,]' '{print $1,$3}'|while read a b
do
mount -o rw,remount $a $b &>/dev/null
done
crondID=`pgrep crond`
kill -9 $crondID 2>/dev/null
rm -rf /var
# 加固SD卡的广告文件(夹)，防写入
cat >$sd/adzw.txt <<-eof
.adiu
.BD_SAPI_CACHE
.betadatastorage
.betautsystemconfig
.cc
.com.taobao.dp
.DataStorage
.gd_file
.gd_fs0
.gd_fs3
.gd_fs6
.gs_file
.gs_fs0
.gs_fs3
.gs_fs6
.im
.protected_image
.Rcs
.sys.log
.SystemConfig
.tbs
.td-3
.tdck
.teemo
.turingdebug
.UTSystemConfig
.vivo
.vivo bytedance
.xlDownload
Android/data/com.sohu.inputmethod.sogou/files/flx/templates
Android/data/com.taobao.taobao/files/.gs_file
Android/data/com.taobao.taobao/files/.gs_fs0
Android/data/com.taobao.taobao/files/.gs_fs3
Android/data/com.taobao.taobao/files/.gs_fs6
autonavi
backups/.SystemConfig
baidu/tempdata
Catfish
cmcc_sso_south_log
com.miui.guardprovider_TMF_TMS
device_known
images
JuphoonService
MQ
openamaplocationsdk
OSSLog
p2plog
qmt
QQBrowser
ramdump
setup
SogouReader
Tencent/tbs
ucgamesdk
Ulike
XHS
eof
for adz0 in `cat $sd/adzw.txt`;do
  chattr -R -i "$sd/$adz0" >/dev/null 2>&1
  chmod -R 777 "$sd/$adz0" >/dev/null 2>&1
  rm -rf "$sd/$adz0"
done
rm -f $sd/adzw.txt

# data搜索ad、.um、.uxx文件(含SD卡)
find /data \( -iname "ad" -o -iname "AdHub" -o -iname "ads" -o -iname "*_ad" -o -iname "*_ads" -o -iname "*_ad_*" -o -iname "ad_*" -o -iname "ads_*" -o -iname "brandad" -o -iname "miad" -o -iname "MiPushLog" -o -iname "msflogs" -o -iname "startupsplash" -o -iname "splash" -o -iname "tbslog" -o -iname ".u" -o -iname ".um" -o -iname ".uuid" -o -iname ".uxx" -o -iname ".vy" -o -iname ".yyy" -o -iname "um" -o -iname "uuid" -o -iname "uxx" -o -iname "debug_log" \) 2>/dev/null|sed -e '/.so/ d' -e '/.sh/ d' -e '/.db/ d' -e '/.xml/ d' -e '/.crc/ d' >>$sd/adzw_ad.txt
while read adz0;do
    chattr -R -i $adz0 >/dev/null 2>&1
    chmod -R 777 $adz0 >/dev/null 2>&1
    rm -rf $adz0
done < $sd/adzw_ad.txt
wait
rm -rf $sd/FileClear_zw_* $sd/adzw*.txt