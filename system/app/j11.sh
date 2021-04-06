#!/system/bin/sh

sd=/data/media/0
rm -rf $sd/adzw*
nowtime=`date +"%m-%d_%T"`
test -x /data/adb/modules/linux_fullcommands/system/bin/find && module_11=1 || module_11=2
test -x /data/adb/modules/zw_fileclear/system/bin/find && module_11=3 || module_11=4
test -x /data/data/com.termux/files/usr/bin/find && module_12=1 || module_12=2
test -f $sd/find -a -f $sd/gawk -a -f $sd/xargs && module_13=1 || module_13=2
test "$module_11" != "1" -o "$module_11" != "3" && test "$module_12" != "1" -a "$module_13" != "1" && { echo -e "\033[31m   此运行环境缺少完整的find、gawk、xargs命令\n   3秒后退出... ... \033[0m \a";sleep 3s;exit 1;}
sh_dir=`cd "$(dirname "${BASH_SOURCE-$0}")";pwd`   # 获取本脚本所在目录
test "$sh_dir" = "/data/adb/modules/zw_fileclear" -o "$sh_dir" = "/system/bin" -o "$sh_dir" = "/system/app" && module_21=1 || module_21=2
PRELOAD_1=`echo $LD_PRELOAD`
PREFIX_1=`echo $PREFIX`
test "$PRELOAD_1" = "/data/data/com.termux/files/usr/lib/libtermux-exec.so" -a "$PREFIX_1" = "/data/data/com.termux/files/usr" && module_22=1 || module_22=2
test_1(){
sh -c "[[ $sd ]]" &>/dev/null
test "`echo $?`" != "0" && { echo -e "\033[31m   此运行环境无法执行 [[ 命令\n   3秒后退出... ... \033[0m \a";sleep 3s;exit 1;}
}
test_find_gawk_xargs(){
[[ -x $sd/find ]] && { find_1=1;find_2=$sd/find;} || chmod 777 $sd/find 2>/dev/null
[[ ! -x $sd/find ]] && { find_1=2;find_2=`type find | awk '{print $3}'`;echo -e "   无法为SD卡中的find命令赋执行权,采用本终端自带命令\n   脚本运行中可能大量报错，并导致脚本诸多功能无效！\a";sleep 3s;} || { find_1=1;find_2=$sd/find;}
[[ -x $sd/gawk ]] && awk_2=$sd/gawk || chmod 777 $sd/gawk 2>/dev/null
[[ ! -x $sd/gawk ]] && { awk_2=`type gawk | awk '{print $3}'`;echo -e "   无法为SD卡中的gawk命令赋执行权,采用本终端自带命令\n      脚本运行中可能大量报错，并导致脚本诸多功能无效！\a";sleep 3s;} || awk_2=$sd/gawk
[[ -x $sd/xargs ]] && xargs_2=$sd/xargs || chmod 777 $sd/xargs 2>/dev/null
[[ ! -x $sd/xargs ]] && { xargs_2=`type xargs | awk '{print $3}'`;echo -e "   无法为SD卡中的xargs命令赋执行权,采用本终端自带命令\n      脚本运行中可能大量报错，并导致脚本诸多功能无效！\a";sleep 3s;} || xargs_2=$sd/xargs
}
if test "$module_21" = "1"
then
  rm -rf $sd/FileClear_zw_$nowtime.txt &>/dev/null
  touch $sd/FileClear_zw_$nowtime.txt
  echo "   ****** 检测到FileClear_for_ZW正在Magisk面具中执行 ******" >$sd/FileClear_zw_$nowtime.txt
  find_1=1
  find_2="/system/bin/find"
  awk_2="/system/bin/gawk"
  xargs_2="/system/bin/xargs"
  echo -e "   \$find_1=$find_1\n   \$find_2=$find_2\n   \$awk_2=$awk_2\n   \$xargs_2=$xargs_2" >>$sd/FileClear_zw_$nowtime.txt
  test_1
  echo -e "   test_[]命令测试通过" >>$sd/FileClear_zw_$nowtime.txt
elif test "$module_22" = "1"
then
  sh_1=`type sh | gawk '{print $3}'`
  test -n "$sh_1" -a "$sh_1" != "aliased" && { alias sh=bash;module_31=1;}
  find_1=1
  find_2="/data/data/com.termux/files/usr/bin/find"
  awk_2="/data/data/com.termux/files/usr/bin/gawk"
  xargs_2="/data/data/com.termux/files/usr/bin/xargs"
  test_1
  echo "   检测到脚本正在Termux中执行"
else
  if test "$module_11" = "1" -o "$module_11" = "3";then
    find_1=1
    find_2="/system/bin/find"
    awk_2="/system/bin/gawk"
    xargs_2="/system/bin/xargs"
    test_1
    echo -e "   检测到您有安装ZW相关模块，将采用模块自带命令\n   检测到脚本正在其他终端中执行，不能确保顺利、完整的执行完毕！\a"
  elif test "$module_13" = "1";then
    test_1
    test_find_gawk_xargs
    echo -e "   检测到脚本正在其他终端中执行，不能确保顺利、完整的执行完毕！\a"
  else
    test "$module_12" = "1" && { echo -e "   检测到您有安装Termux终端模拟器APP\n   强烈建议Ctrl+C终止脚本运行，然后在Termux中运行！\a";sleep 10s;} || { echo -e "\033[31m   此运行环境缺少完整的命令\n   3秒后退出... ... \033[0m \a";sleep 3s;exit 1;}
  fi
fi
[[ `id -u` != "0" ]] && echo -e "   非root用户，无法全面清理垃圾\a"
if [[ `getenforce` = "Enforcing" || `getenforce` = "enforcing" ]]
then
  SELinux_on=1
  setenforce 0
  if [[ `getenforce` = "Enforcing" || `getenforce` = "enforcing" ]];then
    SELinux_on=2   # 因无法临时关闭SELinux，故设置变量为假，避免执行脚本末尾的开启SELinux指令;
    echo -e "\033[31m   SELinux临时关闭失败，无法彻底清理垃圾 \033[0m \a"
  else
    echo "   SELinux已临时关闭，清理完毕后会重启开启"
  fi
else
  SELinux_on=2
  echo "   SELinux原始状态:Off"
fi
mount|grep "ro,"|grep -v "/sbin/.magisk/"|$awk_2 -F'[ ,]' '{print $1,$3}'|while read a b
do
mount -o rw,remount $a $b &>/dev/null
[[ $? == "0" ]] && echo -e "\033[32m   挂载$b为可写成功 \033[0m" || echo -e "\033[31m   挂载$b为可写失败 \033[0m"
[[ $? != "0" ]] && [[ $b == "/" || $b == "/system" || $b == "/data" ]] && { echo -e "\033[31m   $b目录无写权限，无法全面清理垃圾\n   3秒后退出 \033[0m \a";sleep 3;exit 1;}
done
echo ""
echo "   开始关闭部分系统APP和所有第三方APP"
{ killapp_1=(com.android.calendar com.android.camera com.android.providers.calendar com.android.provision com.android.soundrecorder com.android.thememanager com.android.updater com.miui.backup com.miui.cloudbackup com.miui.gallery com.miui.hybrid com.miui.micloudsync com.miui.newhome com.miui.personalassistant com.miui.smarttravel com.miui.yellowpage com.xiaomi.account com.xiaomi.market);
killapp_2=`/system/bin/pm list package -3|$awk_2 -F ':' '{print $2}'|sed -e '/io.neoterm/ d' -e '/com.termux/ d' -e '/com.topjohnwu.magisk/ d' -e '/com.sohu.inputmethod.sogou/ d'`;
for killapp_3 in ${killapp_1[*]} $killapp_2;
do
  PID_temp=`pidof -s $killapp_3`;
  [[ $PID_temp ]] && kill -15 $PID_temp;
  [[ $PID_temp && $? != "0" ]] && kill -9 $PID_temp;
  unset PID_temp;
  /system/bin/am force-stop $killapp_3;
done;
/system/bin/am kill-all;} &
start_used_allsys=`df /apex /cache /cust /data /dev /metadata /mnt /sys /system /vendor 2>/dev/null|$awk_2 'NR!=1 {used+=$3}END{used=used/1024;print used}' 2>/dev/null`
start_used_data=`du -smL /data/ 2>/dev/null|$awk_2 '{print $1}' 2>/dev/null`
start_used_sd=`du -smL $sd/ 2>/dev/null|$awk_2 '{print $1}' 2>/dev/null`
start_used_sdandro=`du -smL $sd/Android/ 2>/dev/null|$awk_2 '{print $1}' 2>/dev/null`
wait
starttime=`date +%s`
echo 3 > /proc/sys/vm/drop_caches
echo "   缓存和内存清理完毕 ！"

cat >$sd/adzw.txt <<-eof
360
139light
..ccdid
..ccvid
.[0-9][0-9][0-9]*
._android.dat
._driver.dat
._system.dat
.a.dat
.acc.dat
.acs
.adtemp
.aio.dat
.android
.androidsystem
.aoe
.appcenterwebbuffer*
.com.*
.ddid*
.gnupg
.imei.txt
.mn_[0-9][0-9]*
.omgid
.turing.dat
.ufs
[0-9]
360Browser
360download
360LiteBrowser
accmeta_vod/pcdn
ALIMP
[Aa]lipay
ali[Uu]nion_apk
AllenVersionPath
[Aa][Mm]ap
android.permission.test
Android/.[0-9a-z][0-9a-z][A-Z]*
Android/.appid
Android/.iacovnfld.
Android/.mt_*
Android/[0-9a-zA-Z][0-9]*
Android/qidm
Android/sdk_patch
androidsystem
[Aa]t
[Bb]rowser
cmb.pb/avatar
cmcc_sso_*
com
com.baidu.homework/files/brandad/
com.baidu.homework/files/image/
com.cmcm.armorflytemp
com.cn21.yj
com.daxiaamu.op5mutoolsnew/magiskunpack
com.kugou.android_KcSdk
com.lingan.yunqi_bitmapCache
com.mt.mtxx.mtxx
com.netease.cloudmusic
com.oneplus.gallery/files/recyclebin
com.qtrun.QuickTest
com.quark.browser
com.sogou.passport
com.taptap/files/dcim/startupsplash
com.youku.phone/files/ad
config_system_switchs.txt
configmanager.json
data
DCIM/.thumbnails
DCIM/.tmfs
DCIM/.tmsdual
dctp
deviceid.txt
dgmandroidlog.txt
dht.id
dhtnodes.dat
dhtnodes6.dat
di.txt
diamond
dianping
did
dmzj
[Dd]ocuments
documentsuuid
download_info
Download/.cu
Download/com.xiaomi.market
Downloads/com.tencent.gamecenter.wadl
e.g
eg.a
emlibs
eventcon
expand_log.txt
fac_sources
flywheel
gaint_dcconfig
gdtdownload
gensee
gifshow
guardlibs
Han.GJZS
hcdnlivenet.ini
huawei/magazineupdate/download
huawei/themes
hubble
iciba
ImageCacheDefault
imnet
installation
installation_new
intent
jisuoffice/极速Office指南
[Kk]gmusic.ver
[Kk]ugou
[Kk]ugou_down_c
[Kk]uwo[Mm]usic
ladengsdk
launcher_new2.png
libs
log
logback
logger
logn
logs
m4399_sdk
m4399sdk
mace_run
[Mm]asterArchive
mcloudsdk
mfcache
migamecenter
MiMarket
MIUI/.wallpaper_history
MIUI/Gallery/cloud/.microthumbnailFile
MIUI/Gallery/cloud/.trashBin
MIUI/Gallery/cloud/thumbnaifile
mob
monitor
mq
msc
msf
mtdownload
MT2
MToolkit
mzywnew.data
ndfsc
nebula
netease
netease_pushservice
news_article
[Nn]otifications
null
org.thunderdog.challegram/files/animations
org.thunderdog.challegram/files/documents
org.thunderdog.challegram/files/music
org.thunderdog.challegram/files/photos
org.thunderdog.challegram/files/videos
Pictures/.gallery2/recycle
Pictures/CoolMarket
Pictures/taobao
pindd
qidm
qiyi
qmt
QQChess
qqstory
qtaudioengine
ramfs_ext
rcs
recovery
routeguidance
sam
sdghookapi.dat
setup
shumei.txt
sina
sina/weibo/storage/photoalbum_pic
sitemp
sogou/.hotexp
sogou/.trick
sogou/corelog
sogou/download
sogou/voice
SogouExplorer
sonicresource
speakerdata48.pcm
speedsoftware/extracted
storage
system
Telegram/Telegram Images
Telegram/Telegram Video
Telegram/Telegram Audio
Telegram/Telegram Documents
[Tt]encent/beacon
[Tt]encent/blob
[Tt]encent/com
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/bizimg
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/favoffline
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/favorite
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image2
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/oneday
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/recbiz
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/video
[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/video2
[Tt]encent/MicroMsg/bigfile
[Tt]encent/MicroMsg/CheckResUpdate
[Tt]encent/MicroMsg/sns_ad_landingpages
[Tt]encent/MicroMsg/vusericon
[Tt]encent/MicroMsg/wallet_images
[Tt]encent/MicroMsg/wxafiles/[a-z][a-z][a-z0-9]*
[Tt]encent/mini
[Tt]encent/MobileQQ
[Tt]encent/MobileQQ/.apollo/rsc_jsonconfig/100_1_all_room3d
[Tt]encent/MobileQQ/.corlornick
[Tt]encent/MobileQQ/.emotionsm
[Tt]encent/MobileQQ/.font_effect
[Tt]encent/MobileQQ/.font_info
[Tt]encent/MobileQQ/.fontbubble
[Tt]encent/MobileQQ/.gift
[Tt]encent/MobileQQ/.hiboom_font
[Tt]encent/MobileQQ/.now_video
[Tt]encent/MobileQQ/.pendant
[Tt]encent/MobileQQ/.readInjoy
[Tt]encent/MobileQQ/.signaturetemplate
[Tt]encent/MobileQQ/.troop
[Tt]encent/MobileQQ/.vipicon
[Tt]encent/MobileQQ/aio_long_shot
[Tt]encent/MobileQQ/appicon
[Tt]encent/MobileQQ/ar_feature
[Tt]encent/MobileQQ/ar_model
[Tt]encent/MobileQQ/artfilter
[Tt]encent/MobileQQ/avatarpendantdefaulthead
[Tt]encent/MobileQQ/avatarpendanticons
[Tt]encent/MobileQQ/bless
[Tt]encent/MobileQQ/bubble_info
[Tt]encent/MobileQQ/capture_ptv_template
[Tt]encent/MobileQQ/capture_qsvf
[Tt]encent/MobileQQ/card
[Tt]encent/MobileQQ/chatpic
[Tt]encent/MobileQQ/doodle_template
[Tt]encent/MobileQQ/doutures
[Tt]encent/MobileQQ/dov_doodle_music
[Tt]encent/MobileQQ/dov_doodle_sticker
[Tt]encent/MobileQQ/dov_doodle_template
[Tt]encent/MobileQQ/dov_ptv_template_dov
[Tt]encent/MobileQQ/dynamic_text
[Tt]encent/MobileQQ/flashchat
[Tt]encent/MobileQQ/foward_urldrawable
[Tt]encent/MobileQQ/funcall
[Tt]encent/MobileQQ/head/_dynamic
[Tt]encent/MobileQQ/head/_hd
[Tt]encent/MobileQQ/head/_SSOhd
[Tt]encent/MobileQQ/head/_st
[Tt]encent/MobileQQ/head/_stranger
[Tt]encent/MobileQQ/hotimage
[Tt]encent/MobileQQ/hotpic
[Tt]encent/MobileQQ/iar
[Tt]encent/MobileQQ/information_paster
[Tt]encent/MobileQQ/keyword_emotion
[Tt]encent/MobileQQ/listentogether
[Tt]encent/MobileQQ/ocr
[Tt]encent/MobileQQ/photo
[Tt]encent/MobileQQ/play_show_apng
[Tt]encent/MobileQQ/portrait
[Tt]encent/MobileQQ/ppt
[Tt]encent/MobileQQ/pubaccount
[Tt]encent/MobileQQ/qbiz
[Tt]encent/MobileQQ/qbosssplahad
[Tt]encent/MobileQQ/qqcomic
[Tt]encent/MobileQQ/qqconnect
[Tt]encent/MobileQQ/qqmusic
[Tt]encent/MobileQQ/qqstory
[Tt]encent/MobileQQ/rijmmkv
[Tt]encent/MobileQQ/scribble
[Tt]encent/MobileQQ/shortvideo
[Tt]encent/MobileQQ/status_ic
[Tt]encent/MobileQQ/sticker_recommended_pics
[Tt]encent/MobileQQ/subscribe_draft
[Tt]encent/MobileQQ/subscribe_draft_simple
[Tt]encent/MobileQQ/sv_config_resource
[Tt]encent/MobileQQ/[Tt]encent/Mobileqq/webso
[Tt]encent/MobileQQ/thumb
[Tt]encent/MobileQQ/thumb2
[Tt]encent/MobileQQ/video_story
[Tt]encent/MobileQQ/viola
[Tt]encent/MobileQQ/voicechange
[Tt]encent/MobileQQ/webviewcheck
[Tt]encent/MobileQQ/zhitu
[Tt]encent/mta
[Tt]encent/QQ_cameraemo
[Tt]encent/QQ_collection/pic
[Tt]encent/QQ_favorite
[Tt]encent/QQ_Images/qqeditpic
[Tt]encent/QQfile_recv
[Tt]encent/qqhomework_attach
[Tt]encent/qqhomework_recv
[Tt]encent/QQLite/.emotionsm
[Tt]encent/QQLite/ArkApp
[Tt]encent/QQLite/data
[Tt]encent/QQLite/early
[Tt]encent/qzone
[Tt]encent/readerzone
[Tt]encent/vs
[Tt]encent/WeiXin/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image2
[Tt]encent/WeiXin/bigfile
[Tt]encent/WeiXin/sns_ad_landingpages
[Tt]encent/wtlogin
[Tt]encentmapsdk
tmsdual_shark_mq.bat
TunnelRecord.db
TWRP
txrtmp
usex
UZMap
vipermusic.ver
vlog.xml
Wchat
websites
weishi_yt_mode
weixinfanyi
wesee_interaction_sdk
wpkflowlog.txt
wwise_cfg.txt
[Xx]iaomi
[Xx]inhao
xlDownload
Youdao
yplogfile
zhihu
zman
eof
cat $sd/adzw.txt|$xargs_2 -P 80 -I adz0 sh -c "echo $sd/adz0 >>$sd/adzw_list.txt;chattr -R -i $sd/adz0 >/dev/null 2>&1;rm -rf $sd/adz0 2>>$sd/adzw_3_err.txt"
num_3_0=`wc -l $sd/adzw_list.txt|$awk_2 '{print $1}'`
cat $sd/adzw_list.txt >>$sd/adzw_0.txt
wait
cat $sd/adzw.txt|$xargs_2 -P 80 -I adz0 rm -r $sd/adz0 2>/dev/null
rm -f $sd/adzw.txt $sd/adzw_list.txt && echo "   sd卡根目录特定文件(夹)清理完毕 ！"
unset adz0

cat >$sd/adzw.txt <<-eof
.com.meizu.filemanager/.garbage
.dxData.db
.m5s
cmb.pb/files/cmb830/marketingpath/file/mppic
cn.kuwo.player/files/Kuwomusic/.localhtml
cn.kuwo.player/files/Kuwomusic/.pendant
cn.kuwo.player/files/Kuwomusic/.videoUpload
cn.kuwo.player/files/Kuwomusic/picture
cn.kuwo.player/files/Kuwomusic/screenad
com.amap.android.ams/files/amaplocation/flp
com.android.browser/files/data/banners
com.android.camera
com.autonavi.minimap/files/alipay/com.autonavi.minimap/nebuladownload/downloads
com.autonavi.minimap/files/amap/com.autonavi.minimap/applogic
com.autonavi.minimap/files/amaplocation/autonavi/indoor
com.autonavi.minimap/files/autonavi
com.autonavi.minimap/files/nebulah5app
com.autonavi.minimap/files/nebulainstallapps
com.autonavi.minimap/files/splash
com.autonavi.minimap/files/tinyappdb
com.autonavi.minimap/files/trackPost
com.baidu.baidumap/baidumap/bnav/guidancecloud
com.baidu.baidumap/files/wbfilecache/walk
com.baidu.homework/files/brandad
com.baidu.homework/files/image
com.baidu.input_yijia/files/skin_update
com.bilibili.app.in/files/heartbeat_report
com.cainiao.wireless/files/amapcn
com.cainiao.wireless/files/splash_ads
com.coolapk.market/files/rough_draft/rough_draft.bin
com.eg.android.AlipayGphone/files/app_alipay_msp_disk_cache
com.eg.android.AlipayGphone/files/applogic
com.eg.android.AlipayGphone/files/emojifiles
com.eg.android.AlipayGphone/files/emotion
com.eg.android.AlipayGphone/files/Memory/errormaps
com.eg.android.AlipayGphone/files/multimedia
com.eg.android.AlipayGphone/files/sdcard
com.eg.android.AlipayGphone/files/securitycacheservicestorage
com.eg.android.AlipayGphone/files/trafficlogic
com.eg.android.AlipayGphone/files/perf
com.eg.android.AlipayGphone/nebuladownload
com.eg.android.AlipayGphone/openplatform
com.estrongs.android.pop/cache
com.chinamobile.mcloud/files/[Tt]encent/tbs_live_log/com.chinamobile.mcloud
com.meizu.account
com.meizu.mzsyncservice
com.meizu.sceneinfo
com.miui.player/files
com.qihoo.contents/cache
com.qiyi.video/files/plugin_debug
com.qiyi.video/files/quill
com.qzone
com.snssdk.api
com.snssdk.api.embed
com.sohu.inputmethod.sogou/files/flx
com.ss.android.ugc.aweme/files/apks
com.ss.android.ugc.aweme/files/livewallpaper
com.ss.android.ugc.aweme/files/mediattmp
com.ss.android.ugc.aweme/files/music/download
com.taobao.idlefish/files/ad
com.taobao.idlefish/image
com.taobao.taobao/files/acds
com.taobao.taobao/files/amapcn
com.taobao.taobao/files/AsyncPublishDraft
com.taobao.taobao/files/downloads
com.taobao.taobao/files/persistent_store
com.tencent.mm/beacon
com.tencent.mm/blob
com.tencent.mm/cache
com.tencent.mm/com
com.tencent.mm/files/data
com.tencent.mm/files
com.tencent.mm/MicroMsg/.tmp
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/attachment
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/bizimg
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/emoji
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/favoffline
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/favorite
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image2
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/mailapp
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/openim
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/recbiz
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/record
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/video
com.tencent.mm/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/video2
com.tencent.mm/MicroMsg/bigfile
com.tencent.mm/MicroMsg/browser
com.tencent.mm/MicroMsg/CDNTemp
com.tencent.mm/MicroMsg/CheckResUpdate
com.tencent.mm/MicroMsg/crash
com.tencent.mm/MicroMsg/facedir
com.tencent.mm/MicroMsg/fts
com.tencent.mm/MicroMsg/Game
com.tencent.mm/MicroMsg/mapsdk/[Tt]encentmapsdk/com.tencent.mm/data/v[0-9]/render/events/icons/
com.tencent.mm/MicroMsg/recovery/version.info
com.tencent.mm/MicroMsg/sns_ad_landingpages
com.tencent.mm/MicroMsg/vusericon
com.tencent.mm/MicroMsg/wallet
com.tencent.mm/MicroMsg/wallet_images
com.tencent.mm/MicroMsg/wxacache
com.tencent.mm/MicroMsg/wxafiles
com.tencent.mm/MicroMsg/wxanewfiles
com.tencent.mm/MobileQQ/doutures
com.tencent.mm/MobileQQ/subscribe_draft
com.tencent.mm/MobileQQ/subscribe_draft_simple
com.tencent.mm/mta
com.tencent.mm/QQfile_recv
com.tencent.mm/vs
com.tencent.mobileqq/files/ae
com.tencent.mobileqq/files/qwallet/.preloaduni
com.tencent.mobileqq/[Tt]encent/beacon
com.tencent.mobileqq/[Tt]encent/blob
com.tencent.mobileqq/[Tt]encent/com
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/bizimg
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/favoffline
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/favorite
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image2
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/oneday
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/recbiz
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/video
com.tencent.mobileqq/[Tt]encent/MicroMsg/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/video2
com.tencent.mobileqq/[Tt]encent/MicroMsg/bigfile
com.tencent.mobileqq/[Tt]encent/MicroMsg/CheckResUpdate
com.tencent.mobileqq/[Tt]encent/MicroMsg/sns_ad_landingpages
com.tencent.mobileqq/[Tt]encent/MicroMsg/vusericon
com.tencent.mobileqq/[Tt]encent/MicroMsg/wallet_images
com.tencent.mobileqq/[Tt]encent/MicroMsg/wxafiles/[a-z][a-z][a-z0-9]*
com.tencent.mobileqq/[Tt]encent/mini
com.tencent.mobileqq/[Tt]encent/MobileQQ/.apollo/rsc_jsonconfig
com.tencent.mobileqq/[Tt]encent/MobileQQ/.corlornick
com.tencent.mobileqq/[Tt]encent/MobileQQ/.emotionsm
com.tencent.mobileqq/[Tt]encent/MobileQQ/.font_effect
com.tencent.mobileqq/[Tt]encent/MobileQQ/.font_info
com.tencent.mobileqq/[Tt]encent/MobileQQ/.fontbubble
com.tencent.mobileqq/[Tt]encent/MobileQQ/.gift
com.tencent.mobileqq/[Tt]encent/MobileQQ/.hiboom_font
com.tencent.mobileqq/[Tt]encent/MobileQQ/.now_video
com.tencent.mobileqq/[Tt]encent/MobileQQ/.pendant
com.tencent.mobileqq/[Tt]encent/MobileQQ/.readInjoy
com.tencent.mobileqq/[Tt]encent/MobileQQ/.signaturetemplate
com.tencent.mobileqq/[Tt]encent/MobileQQ/.troop
com.tencent.mobileqq/[Tt]encent/MobileQQ/.vipicon
com.tencent.mobileqq/[Tt]encent/MobileQQ/aio_long_shot
com.tencent.mobileqq/[Tt]encent/MobileQQ/appicon
com.tencent.mobileqq/[Tt]encent/MobileQQ/ar_feature
com.tencent.mobileqq/[Tt]encent/MobileQQ/ar_model
com.tencent.mobileqq/[Tt]encent/MobileQQ/artfilter
com.tencent.mobileqq/[Tt]encent/MobileQQ/avatarpendantdefaulthead
com.tencent.mobileqq/[Tt]encent/MobileQQ/avatarpendanticons
com.tencent.mobileqq/[Tt]encent/MobileQQ/bless
com.tencent.mobileqq/[Tt]encent/MobileQQ/bubble_info
com.tencent.mobileqq/[Tt]encent/MobileQQ/capture_ptv_template
com.tencent.mobileqq/[Tt]encent/MobileQQ/capture_qsvf
com.tencent.mobileqq/[Tt]encent/MobileQQ/card
com.tencent.mobileqq/[Tt]encent/MobileQQ/chatpic
com.tencent.mobileqq/[Tt]encent/MobileQQ/com.tencent.mobileqq/[Tt]encent/Mobileqq/webso
com.tencent.mobileqq/[Tt]encent/MobileQQ/doodle_template
com.tencent.mobileqq/[Tt]encent/MobileQQ/doutures
com.tencent.mobileqq/[Tt]encent/MobileQQ/dov_doodle_music
com.tencent.mobileqq/[Tt]encent/MobileQQ/dov_doodle_sticker
com.tencent.mobileqq/[Tt]encent/MobileQQ/dov_doodle_template
com.tencent.mobileqq/[Tt]encent/MobileQQ/dov_ptv_template_dov
com.tencent.mobileqq/[Tt]encent/MobileQQ/dynamic_text
com.tencent.mobileqq/[Tt]encent/MobileQQ/flashchat
com.tencent.mobileqq/[Tt]encent/MobileQQ/foward_urldrawable
com.tencent.mobileqq/[Tt]encent/MobileQQ/funcall
com.tencent.mobileqq/[Tt]encent/MobileQQ/head/_dynamic
com.tencent.mobileqq/[Tt]encent/MobileQQ/head/_hd
com.tencent.mobileqq/[Tt]encent/MobileQQ/head/_SSOhd
com.tencent.mobileqq/[Tt]encent/MobileQQ/head/_st
com.tencent.mobileqq/[Tt]encent/MobileQQ/head/_stranger
com.tencent.mobileqq/[Tt]encent/MobileQQ/hotimage
com.tencent.mobileqq/[Tt]encent/MobileQQ/hotpic
com.tencent.mobileqq/[Tt]encent/MobileQQ/iar
com.tencent.mobileqq/[Tt]encent/MobileQQ/information_paster
com.tencent.mobileqq/[Tt]encent/MobileQQ/keyword_emotion
com.tencent.mobileqq/[Tt]encent/MobileQQ/listentogether
com.tencent.mobileqq/[Tt]encent/MobileQQ/ocr
com.tencent.mobileqq/[Tt]encent/MobileQQ/photo
com.tencent.mobileqq/[Tt]encent/MobileQQ/play_show_apng
com.tencent.mobileqq/[Tt]encent/MobileQQ/portrait
com.tencent.mobileqq/[Tt]encent/MobileQQ/ppt
com.tencent.mobileqq/[Tt]encent/MobileQQ/pubaccount
com.tencent.mobileqq/[Tt]encent/MobileQQ/qbiz
com.tencent.mobileqq/[Tt]encent/MobileQQ/qbosssplahad
com.tencent.mobileqq/[Tt]encent/MobileQQ/qqcomic
com.tencent.mobileqq/[Tt]encent/MobileQQ/qqconnect
com.tencent.mobileqq/[Tt]encent/MobileQQ/qqmusic
com.tencent.mobileqq/[Tt]encent/MobileQQ/qqstory
com.tencent.mobileqq/[Tt]encent/MobileQQ/rijmmkv
com.tencent.mobileqq/[Tt]encent/MobileQQ/scribble
com.tencent.mobileqq/[Tt]encent/MobileQQ/shortvideo
com.tencent.mobileqq/[Tt]encent/MobileQQ/status_ic
com.tencent.mobileqq/[Tt]encent/MobileQQ/sticker_recommended_pics
com.tencent.mobileqq/[Tt]encent/MobileQQ/subscribe_draft
com.tencent.mobileqq/[Tt]encent/MobileQQ/subscribe_draft_simple
com.tencent.mobileqq/[Tt]encent/MobileQQ/sv_config_resource
com.tencent.mobileqq/[Tt]encent/MobileQQ/thumb
com.tencent.mobileqq/[Tt]encent/MobileQQ/thumb2
com.tencent.mobileqq/[Tt]encent/MobileQQ/video_story
com.tencent.mobileqq/[Tt]encent/MobileQQ/viola
com.tencent.mobileqq/[Tt]encent/MobileQQ/voicechange
com.tencent.mobileqq/[Tt]encent/MobileQQ/webviewcheck
com.tencent.mobileqq/[Tt]encent/MobileQQ/zhitu
com.tencent.mobileqq/[Tt]encent/mta
com.tencent.mobileqq/[Tt]encent/QQ_cameraemo
com.tencent.mobileqq/[Tt]encent/QQ_collection/pic
com.tencent.mobileqq/[Tt]encent/QQ_favorite
com.tencent.mobileqq/[Tt]encent/QQ_Images/qqeditpic
com.tencent.mobileqq/[Tt]encent/qqhomework_attach
com.tencent.mobileqq/[Tt]encent/qqhomework_recv
com.tencent.mobileqq/[Tt]encent/QQLite/.emotionsm
com.tencent.mobileqq/[Tt]encent/QQLite/ArkApp
com.tencent.mobileqq/[Tt]encent/qzone
com.tencent.mobileqq/[Tt]encent/readerzone
com.tencent.mobileqq/[Tt]encent/vs
com.tencent.mobileqq/[Tt]encent/WeiXin/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*/image2
com.tencent.mobileqq/[Tt]encent/WeiXin/bigfile
com.tencent.mobileqq/[Tt]encent/WeiXin/sns_ad_landingpages
com.tencent.mobileqq/[Tt]encent/wtlogin
com.tencent.qqmusic/files/qqmusic/.assist
com.tencent.qqmusic/files/qqmusic/eup
com.tencent.qqmusic/files/qqmusic/firstpiece
com.tencent.qqmusic/files/qqmusic/gift_anim_zip
com.tencent.qqmusic/files/qqmusic/landscape
com.tencent.qqmusic/files/qqmusic/machine-learning-download
com.tencent.qqmusic/files/qqmusic/moments
com.tencent.qqmusic/files/qqmusic/network
com.tencent.qqmusic/files/qqmusic/qrc
com.tencent.qqmusic/files/qqmusic/rsconfig_res
com.tencent.qqmusic/files/qqmusic/splash
com.tencent.qqmusic/files/qqmusic/supersound/effects/resae
com.tencent.qqmusic/files/qqmusic/ubc
com.tencent.qqmusic/files/qqmusic/vip_center
com.tencent.xriver/sdcard
com.tencent.xriver/files/tencent
com.topjohnwu.magisk/files
com.xiaomi.vipaccount/files/web_cache
com.xiaomi.vipaccount/files
com.youku.phone/files/1234_ad_assets_display
com.youku.phone/files/danmaku_emptyDir
com.youku.phone/files/danmaku_offline
com.youku.phone/files/danmaku_online
com.youku.phone/files/debug_storage
com.youku.phone/files/hotstartad
com.youku.phone/files/youku/offlinedata
com.youku.phone/sdcard
me.gfuil.bmap/files/amap/data_v6/online
pushSdk
eof
cat $sd/adzw.txt|$xargs_2 -P 80 -I adz0 sh -c "echo $sd/Android/data/adz0 >>$sd/adzw_list.txt;chattr -R -i $sd/Android/data/adz0 >/dev/null 2>&1;rm -rf $sd/Android/data/adz0 2>>$sd/adzw_3_err.txt"
let num_3_0="num_3_0 + `wc -l $sd/adzw_list.txt|$awk_2 '{print $1}'`"
cat $sd/adzw_list.txt >>$sd/adzw_0.txt
wait
cat $sd/adzw.txt|$xargs_2 -P 80 -I adz0 rm -r $sd/Android/data/adz0 2>/dev/null
rm -f $sd/adzw.txt $sd/adzw_list.txt && echo "   sd卡Android特定文件夹清理完毕 ！"
unset adz0

cat >$sd/adzw.txt <<-eof
air.tv.douyu.android/files/ad_imgs
com.alibaba.android.rimet/app_h5apps
com.alibaba.android.rimet/files/dingtalktheone/ariverpackages/downloads
com.alibaba.android.rimet/files/dingtalktheone/ariverpackages/installed
com.alibaba.android.rimet/files/nebulainstallapps
com.android.shell/files/bugreports
com.autonavi.minimap/files/autonaviPRIVATE_DATATunnelRecord.db
com.autonavi.minimap/files/nebulainstallapps
com.autonavi.minimap/files/tinyappdb
com.autonavi.minimap/files/trackPost
com.kuaishou.nebula/files/filedownloader
com.kuaishou.nebula/kwailink
com.lenovo.leos.cloud.sync/apps/susdownload
com.lenovo.ota/files/.dthumb
com.lenovo.safecenter/files/carrierdata
com.letv.android.client/ickeck
com.letv.android.client/letv/share
com.letv.android.client/letv/storage/relevant_data
com.letv.letvshop/files/carrierdata
com.lingan.seeyou/files/carrierdata
com.ludashi.benchmark/.360tctemp
com.madfingergames.monzo/files/ddsdk
com.madfingergames.monzomod/files/al
com.market.chenxiang/files/downloadlog
com.mediatek.factorymode/.snowfoxmsg
com.mediatek.factorymode/files/.up_c0004200
com.meitu.meipaimv/ar/thumbs
com.meitu.meipaimv/toppich5/_dest/js/index
com.meitu.meiyancamera/videocache/adpater
com.meitu.meiyancamera/videocache/myvideos
com.meizu.mstore/tempapk
com.meizu.mstore/tempimage
com.miui.cleanmaster/app_analytics
com.miui.cleanmaster/files/miuisdk
com.mojang.minecraftpe/updates
com.mt.mtxx.mtxx/files/ad_share
com.mt.mtxx.mtxx/files/atcontacts
com.mt.mtxx.mtxx/files/background
com.mt.mtxx.mtxx/files/free_tmp_dic
com.mt.mtxx.mtxx/files/mapps
com.mt.mtxx.mtxx/files/material/assets/fonts
com.mt.mtxx.mtxx/files/material/camerafilters
com.mt.mtxx.mtxx/material/assets/colorful_frame
com.mt.mtxx.mtxx/material/local
com.mt.mtxx.mtxx/material/preview
com.mt.mtxx.mtxx/material/thumbnail
com.mt.mtxx.mtxx/material/zip
com.mydream.wifi/files/downloading
com.mydream.wifi/files/pictures/flash
com.netease.cloudmusic/files/lyrictemplate2
com.netease.cloudmusic/files/lyricvideo
com.netease.cloudmusic/files/mamstatistic
com.netease.cloudmusic/files/mamstatisticv2
com.netease.cloudmusic/files/statistic
com.netease.cloudmusic/files/statisticv2
com.netease.cloudmusic/files/storage/discoverypagebanner
com.netease.newsreader.activity/files/carrierdata
com.neusoft.td.android.wo116114/files/carrierdata
com.oneplus.gallery/databases/recyclebin.db
com.oppo.reader/.datastorage
com.outfit7.mytalkingangelafree/.mobvista700/img
com.outfit7.mytalkingangelafree/files/o7iconscache
com.outfit7.mytalkingtomfree/files/.vungle
com.outfit7.mytalkingtomfree/files/al
com.outfit7.mytalkingtomfree/files/apk
com.outfit7.mytalkingtomfree/files/cache
com.outfit7.mytalkingtomfree/files/dreamingof
com.outfit7.mytalkingtomfree/files/html
com.outfit7.mytalkingtomfree/files/imagecache
com.outfit7.mytalkingtomfree/files/o7mgimgs
com.outfit7.mytalkingtomfree/files/o7mttfbprofimgs
com.outfit7.mytalkingtomfree/files/o7mttmgimgs
com.outfit7.mytalkingtomfree/files/o7socialprofimgs
com.outfit7.mytalkingtomfree/files/o7specialofferimgs
com.outfit7.mytalkingtomfree/files/promocreatives
com.outfit7.mytalkingtomfree/files/shader
com.outfit7.mytalkingtomfree/files/specialofferbackgrounds
com.outfit7.mytalkingtomfree/files/updatebanner
com.outfit7.mytalkingtomfree/files/vghtml/download
com.outfit7.mytalkingtomfree/files/vghtml/extract/img
com.outfit7.mytalkingtomfree/files/videonews
com.outfit7.mytalkingtomfree/files/yume_android_sdk
com.outfit7.mytalkingtomfree/manage
com.paem/files/download_apk
com.pingan.lifeinsurance/files/.resource
com.pingan.papd/files/audios
com.pingan.papd/files/imgs
com.pingan.pinganwifi/files/carrierdata
com.pingan.pinganwifi/files/null/com.pingan.pinganwifi
com.pingan.pinganwifi/files/version
com.pplive.androidphone/files/carrierdata
com.qihoo.appstore/apps
com.qihoo.appstore/icons
com.qihoo.appstore/splash
com.qihoo.browser/files/carrierdata
com.qihoo.cleandroid_cn/.360tctemp
com.qihoo.magic/files/dcsdk
com.qihoo.permmgr/.360tctemp
com.qihoo.permmgr/files/carrierdata
com.qihoo.permmgr/files/dcsdk
com.qihoo.video/360freewifi
com.qihoo.video/download
com.qihoo.video/files/.sfp
com.qihoo.video/files/360cleanmaster
com.qihoo.video/files/360freewifi
com.qihoo.video/files/apkfile
com.qihoo.video/files/bannerapk
com.qihoo.video/files/download
com.qihoo.video/files/gamefile
com.qihoo.video/files/hometabimage
com.qihoo.video/files/softpromotion
com.qihoo.video/files/torch/adres/pic
com.qihoo.video/softpromotion
com.qihoo.video/zhushou
com.qihoo360.mobilesafe/.360tctemp
com.qihoo360.mobilesafe/files/dcsdk
com.qihoo360.mobilesafe/files/fetchgpsinfo.txt
com.qisiemoji.inputmethod/files/koala_analysis
com.qiyi.video/.ppq
com.qiyi.video/.qiyi
com.qiyi.video/app_pluginapp
com.qiyi.video/files/.fingerprintqiyi
com.qiyi.video/files/aiapps_folder
com.qiyi.video/files/aiapps_zip
com.qiyi.video/files/aigames_folder
com.qiyi.video/files/com.qiyi.video.apk
com.qiyi.video/files/corefile
com.qiyi.video/files/gamecenter.zip
com.qiyi.video/files/gamecenter_temp
com.qiyi.video/files/paopao_debug
com.qiyi.video/files/pictures
com.qiyi.video/files/plugin_debug
com.qiyi.video/qiyivideo_local/qiyivideo_91
com.qq.reader/failedtaskdata
com.qq.reader/nativedata
com.qunar/files/baidumapsdknew
com.qunar/files/data
com.qunar/files/hybrid
com.qunar/files/lvtu/cache
com.qunar/files/lvtu/resource
com.qunar/files/qlib
com.qunar/files/qunarphoto
com.qzone/files/uploader
com.qzone/libs
com.qzone/qzone/audio
com.qzone/video
com.samsung.android.app.episodes/testdata
com.samsung.android.keyguardwallpaperupdator/files/cropped_images
com.samsung.indexservice/files/.myfilescontentsearch
com.sankuai.meituan.takeoutnew/files/adstyles
com.sankuai.meituan.takeoutnew/files/carrierdata
com.sds.android.ttpod/.atj/img
com.sds.android.ttpod/.ayyc/ayyc_img
com.sds.android.ttpod/files/awcn_strategy
com.sds.android.ttpod/files/trace
com.sdu.didi.psnger/.locsdk
com.sec.android.app.sbrowser/files/pictures/com.sec.android.app.sbrowser/tabmanager/fullscreenbitmap/instance1
com.sec.android.app.sbrowser/files/pictures/com.sec.android.app.sbrowser/tabmanager/tabbitmap/instance1
com.sec.android.app.sbrowser/tabmanager
com.sec.android.app.shealth/files/accessory
com.sec.android.app.shealth/files/carrierdata
com.sec.android.app.shealth/files/healthdata
com.sec.android.app.shealth/files/message
com.sec.android.app.shealth/files/partnerapp
com.sec.android.app.shealth/files/profile
com.sec.android.app.shealth/profile
com.sec.android.app.shealth/testdata
com.sec.android.gallery3d/testdata
com.sec.android.geolookout/testdata
com.sec.android.widgetapp.ap.hero.accuweather/testdata
com.sec.chaton/file/profile
com.sec.chaton/file/skin_theme
com.sec.chaton/files/[0-9a-za-z]-[0-9a-za-z]-[0-9a-za-z]-[0-9a-za-z]*/thumbnail
com.sec.chaton/files/ams/amsbasicfiles
com.sec.chaton/files/ams/amsuserfiles
com.sec.chaton/files/ams/template
com.sec.chaton/files/ams/userstamp
com.sec.chaton/files/amsbackgrounditem
com.sec.chaton/files/amsstampitem
com.sec.chaton/files/amstemplateitem
com.sec.chaton/files/coverstory
com.sec.chaton/files/localbackup
com.sec.chaton/files/null
com.sec.chaton/files/profile
com.sec.chaton/files/skin
com.sec.chaton/files/skins
com.sec.chaton/files/sound
com.sec.chaton/files/theme
com.sec.chaton/files/thumbnail
com.sec.everglades/files/icons
com.sec.spen.flashannotate/files/pictures
com.sec.spen.flashannotate/files/setting
com.sec.spen.flashannotate/serial
com.seebaby/files/awcn_strategy
com.seebaby/files/rongcloud/file
com.setup.launcher3/files/awcn_strategy
com.sg.sledog/files/recommend
com.sina.news/files/download
com.sina.news/files/splayer
com.sina.news/files/uncleanable
com.sina.weibo.game.football/resource
com.sina.weibo/files/carrierdata
com.sina.weibo/serial
com.sina.weibo/wbc
com.smile.gifmaker/files/filedownloader
com.smile.gifmaker/files/lab
com.smile.gifmaker/kwailink
com.snda.wifilocating/downloads
com.snda.wifilocating/gameplugins/com.snda.wifilocating/files
com.snda.wifilocating/testdata
com.snda.wifilocating/wifimasterkey
com.soft.blued/emotionspack
com.soft.blued/files/emotionspack
com.soft.blued/files/img
com.soft.blued/files/video
com.soft.blued/testdata
com.soft.blued/video
com.sogou.appmall/image
com.sogou.novel/files/.book
com.sogou.novel/files/book
com.sogou.novel/files/data/novel-download
com.sogou.novel/files/data/novel-image
com.sogou.novel/files/data/version
com.sogou.novel/files/html
com.sogou.novel/files/splash
com.sogou.toptennews/files/awcn_strategy
com.sohu.inputmethod.sogou/files/download
com.sohu.inputmethod.sogou/files/expression/expressionrepo/adimage
com.sohu.inputmethod.sogou/files/expression/expressionrepo/icons
com.sohu.inputmethod.sogou/files/expression/expressionrepo/packages
com.sohu.inputmethod.sogou/files/expression/expressionrepo/previews
com.sohu.inputmethod.sogou/files/expression/expressionsearch
com.sohu.inputmethod.sogou/files/expressionrepo/icons
com.sohu.inputmethod.sogou/files/expressionrepo/packages
com.sohu.inputmethod.sogou/files/expressionrepo/previews
com.sohu.inputmethod.sogou/files/sogou_wallpaper
com.sohu.inputmethod.sogou/files/starterpack
com.sohu.inputmethod.sogou/files/wallpaper
com.sohu.inputmethod.sogouoem/files/expression/expressionrepo/adimage
com.sohu.inputmethod.sogouoem/files/expression/expressionrepo/icons
com.sohu.inputmethod.sogouoem/files/expression/expressionrepo/packages
com.sohu.inputmethod.sogouoem/files/expression/expressionrepo/previews
com.sohu.inputmethod.sogouoem/files/expressionrepo/icons
com.sohu.inputmethod.sogouoem/files/expressionrepo/previews
com.sohu.sohuvideo.sdkm/p2p
com.sohu.sohuvideo/apk
com.sohu.sohuvideo/movies
com.sohu.sohuvideo/newsclient
com.sohu.sohuvideo/pausead
com.sohu.sohuvideo/statisticsbehavior
com.sohu.sohuvideo/statisticsplay
com.sohu.sohuvideo/tempvideo
com.sohu.sohuvideo/update
com.sohu.tv/statisticsbehavior
com.sohu.tv/statisticsplay
com.sohu.tv/tempvideo
com.sohu.tv/update
com.songheng.eastnews/logtrace
com.ss.android.article.lite/bytedance
com.ss.android.article.lite/files/awcn_strategy
com.ss.android.article.video/files/awcn_strategy
com.ss.android.article.video/files/plugins
com.ss.android.auto/files/awcn_strategy
com.ss.android.essay.joke/files/update.apk
com.ss.android.essay.joke/videoedit/beauty
com.ss.android.ugc.aweme/files/awcn_strategy
com.ss.android.ugc.aweme/files/crashlognative
com.ss.android.ugc.aweme/files/draft
com.ss.android.ugc.awemeplugin/cachetmpimages
com.ss.android.ugc.awemf/files/npth/ProcessTrack
com.ss.android.ugc.detail/cachetmpimages
com.ss.android.ugc.live/bytedance
com.ss.android.ugc.live/files/awcn_strategy
com.storm.smart/notification_detail
com.taobao.idlefish/files/awcn_strategy
com.taobao.movie.android/files/pictures
com.taobao.movie.android/plugins
com.taobao.qianniu/files/carrierdata
com.taobao.qianniu/files/download
com.taobao.qianniu/files/emoticon
com.taobao.taobao/chatphoto
com.taobao.taobao/com.taobao.taobao/.fg
com.taobao.taobao/com.taobao.taobao/update_cache
com.taobao.taobao/com.taobao.taobao/webview
com.taobao.taobao/downloadsdk
com.taobao.taobao/files/acds
com.taobao.taobao/files/atlas-debug
com.taobao.taobao/files/awcn_strategy
com.taobao.taobao/files/carrierdata
com.taobao.taobao/files/chatphoto
com.taobao.taobao/files/download/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*
com.taobao.taobao/files/download/-[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*
com.taobao.taobao/files/download/puti
com.taobao.taobao/files/download/share_expression/small_man
com.taobao.taobao/files/downloads
com.taobao.taobao/files/expression
com.taobao.taobao/files/festival
com.taobao.taobao/files/ju
com.taobao.taobao/files/magic_mirror
com.taobao.taobao/files/orange_config_content
com.taobao.taobao/files/persistent_store
com.taobao.taobao/files/photo
com.taobao.taobao/files/pictures
com.taobao.taobao/files/pigeon
com.taobao.taobao/files/puti
com.taobao.taobao/files/ranger
com.taobao.taobao/files/tnetlogs
com.taobao.taobao/files/图片
com.taobao.taobao/files/下载
com.taobao.taobao/hybridwebview
com.taobao.taobao/orange_config
com.taobao.taobao/persistent_store
com.taobao.taobao/plugins
com.taobao.taobao/taobao
com.taobao.taobao/taoupdate
com.taobao.taobao/viewdata
com.taobao.taobao/wwresourcecache
com.taobao.trip/.back
com.taobao.trip/files/carrierdata
com.taobao.trip/files/cv1
com.taobao.trip/files/cv2
com.taobao.trip/files/download/tmp_extract
com.taobao.trip/files/update_needed_dir/cv2
com.taobao.trip/files/upgrade_app
com.tencent.game.ssgame/assets/crashscreenshoot
com.tencent.game.ssgame/assets/imagecache
com.tencent.game.ssgame/assets/pic
com.tencent.game.vxdgame/files/documents
com.tencent.game.vxdgame/files/download
com.tencent.game.vxdgame/files/library/documents
com.tencent.game.vxdgame/files/library/iipsfiledir
com.tencent.game.vxdgame/files/library/versionlist
com.tencent.game.vxdgame/files/res
com.tencent.gamejoy/files/download
com.tencent.karaoke/files/chorus
com.tencent.karaoke/files/chorus_config
com.tencent.karaoke/files/chorus_scene
com.tencent.karaoke/files/downloadapk
com.tencent.karaoke/files/hash
com.tencent.karaoke/files/hum
com.tencent.karaoke/files/info
com.tencent.karaoke/files/localsong
com.tencent.karaoke/files/mipushlog
com.tencent.karaoke/files/mv
com.tencent.karaoke/files/mvcover
com.tencent.karaoke/files/note
com.tencent.karaoke/files/obbligato
com.tencent.karaoke/files/pcm
com.tencent.karaoke/files/practice
com.tencent.karaoke/files/qrc
com.tencent.karaoke/files/speedmeasure
com.tencent.karaoke/files/splash
com.tencent.karaoke/files/uploader
com.tencent.karaoke/files/videocache
com.tencent.map/files/sosomap/data/bus
com.tencent.map/files/sosomap/data/cfg
com.tencent.map/files/sosomap/data/download/citydata
com.tencent.map/files/sosomap/data/file_download
com.tencent.map/files/sosomap/data/plugin_dl
com.tencent.map/files/sosomap/data/radio
com.tencent.map/files/sosomap/data/route
com.tencent.map/files/sosomap/data/route_download
com.tencent.map/files/sosomap/data/v3
com.tencent.map/files/sosomap/data/worldmapdownload
com.tencent.map/files/sosomap/nav
com.tencent.map/files/sosomap/nav/zip
com.tencent.minihd.qq/ache/http
com.tencent.minihd.qq/ache/thumbnails
com.tencent.minihd.qq/bg/custom
com.tencent.minihd.qq/image
com.tencent.minihd.qq/imagetemp
com.tencent.minihd.qq/qq
com.tencent.minihd.qq/qzone
com.tencent.minihd.qq/wblog_head
com.tencent.mm/files/kvcomm/monitordata*
com.tencent.mm/files/public/CheckResUpdate
com.tencent.mm/files/public/emoji/res
com.tencent.mm/files/wx[0-9]*/*.apk
com.tencent.mm/MicroMsg/[a-z0-9][a-z0-9][a-z0-9]*/avatar
com.tencent.mm/MicroMsg/[a-z0-9][a-z0-9][a-z0-9]*/image2
com.tencent.mobileqq/app_theme_810
com.tencent.mobileqq/baodownload
com.tencent.mobileqq/files/ArkApp
com.tencent.mobileqq/files/crashinfo
com.tencent.mobileqq/files/maxvideo
com.tencent.mobileqq/files/mini
com.tencent.mobileqq/files/newComeCard
com.tencent.mobileqq/files/Shadowplugin_channel
com.tencent.mobileqq/files/Shadowplugin_core
com.tencent.mobileqq/files/Shadowplugin_misc
com.tencent.mobileqq/files/ShadowPluginManager
com.tencent.mobileqq/files/uploader
com.tencent.mobileqq/files/videocache
com.tencent.mobileqq/qq/video
com.tencent.mobileqq/qzone/avatar
com.tencent.mobileqq/qzone/message_board
com.tencent.mobileqq/qzone/mnt
com.tencent.mobileqq/qzone/sdcard
com.tencent.mobileqq/qzone/storage
com.tencent.mobileqq/qzone/video
com.tencent.mobileqq/shadowplugin_av
com.tencent.mobileqq/shadowplugin_base
com.tencent.mobileqq/shadowplugin_channel
com.tencent.mobileqq/shadowplugin_core
com.tencent.mobileqq/shadowplugin_misc
com.tencent.mobileqq/shadowplugin_odroom
com.tencent.mobileqq/shadowplugin_roombiz
com.tencent.mobileqq/shadowplugin_roomimport
com.tencent.mobileqq/shadowplugin_usercenter
com.tencent.mobileqq/[Tt]encent/qqfile_recv
com.tencent.mtt/serial
com.tencent.news/files/.omgid/dirs
com.tencent.news/files/cell
com.tencent.news/files/data
com.tencent.news/files/dolf
com.tencent.news/files/extended
com.tencent.news/files/favor/detail
com.tencent.news/files/market
com.tencent.news/files/newslog
com.tencent.news/files/onlinelog
com.tencent.news/files/onlinelog4ad
com.tencent.news/files/onlinelog4video
com.tencent.news/files/reader/.offline
com.tencent.news/files/reader/0
com.tencent.news/files/reader/adv
com.tencent.news/files/reader/cover
com.tencent.news/files/reader/default
com.tencent.news/files/reader/download
com.tencent.news/files/reader/epub
com.tencent.news/files/reader/feeddata
com.tencent.news/files/reader/nativecover
com.tencent.news/files/reader/nativedata
com.tencent.news/files/reader/stat
com.tencent.news/files/so
com.tencent.news/files/stat
com.tencent.news/files/sync
com.tencent.news/iles/reader/plugin
com.tencent.pao/files/breezegame
com.tencent.peng/files/documents
com.tencent.peng/files/library/application support/upgrade
com.tencent.qgame/files/freso
com.tencent.qlauncher.lite/files/debug
com.tencent.qlauncher.lite/files/optdefthemeicon
com.tencent.qlauncher.lite/files/opticon
com.tencent.qlauncher.lite/files/optrecommremind
com.tencent.qlauncher.lite/files/recommendicons
com.tencent.qlauncher.lite/files/search
com.tencent.qlauncher.lite/files/theme
com.tencent.qlauncher.lite/files/themes
com.tencent.qlauncher.lite/files/wallpaper/cropped
com.tencent.qlauncher.lite/files/wallpaper/other
com.tencent.qlauncher.lite/files/wallpaper/preview
com.tencent.qlauncher.lite/files/wallpaper/proto
com.tencent.qlauncher.lite/files/wallpaper/thumbnail
com.tencent.qlauncher.lite/wallpaper/cropped
com.tencent.qqcamera/cache/local_db
com.tencent.qqcamera/files/opad
com.tencent.qqgame/cache/file/image
com.tencent.qqlite/app_installed_plugin
com.tencent.qqlite/app_plugin_download
com.tencent.qqlite/app_tombs
com.tencent.qqlite/files/arkapp/install
com.tencent.qqlite/files/mini/[0-9a-zA-Z][0-9a-zA-Z][0-9a-z]*
com.tencent.qqlive/files/.omgid/dirs
com.tencent.qqlive/files/.startheme
com.tencent.qqlive/files/.webapp
com.tencent.qqlive/files/ad/video
com.tencent.qqlive/files/apk
com.tencent.qqlive/files/image
com.tencent.qqlive/files/qqlive
com.tencent.qqlive/files/videodetail
com.tencent.qqlive/files/videos
com.tencent.qqlive/ickeck
com.tencent.qqlive/playcache
com.tencent.qqlive/[Tt]encent/qqlive/.webapp
com.tencent.qqlive/[Tt]encent/qqlive/imagecache
com.tencent.qqmusic/files/download
com.tencent.qqmusic/files/mipushlog
com.tencent.qqmusic/files/qqmusic/album
com.tencent.qqmusic/files/qqmusic/apk
com.tencent.qqmusic/files/qqmusic/config
com.tencent.qqmusic/files/qqmusic/downloadalbum
com.tencent.qqmusic/files/qqmusic/dts/assets
com.tencent.qqmusic/files/qqmusic/dts/meta-inf
com.tencent.qqmusic/files/qqmusic/dts/res
com.tencent.qqmusic/files/qqmusic/dts_aduto
com.tencent.qqmusic/files/qqmusic/dts_auto
com.tencent.qqmusic/files/qqmusic/encrypt
com.tencent.qqmusic/files/qqmusic/eup
com.tencent.qqmusic/files/qqmusic/fingerprint
com.tencent.qqmusic/files/qqmusic/firstpiece
com.tencent.qqmusic/files/qqmusic/fonts
com.tencent.qqmusic/files/qqmusic/head
com.tencent.qqmusic/files/qqmusic/icon
com.tencent.qqmusic/files/qqmusic/imageex
com.tencent.qqmusic/files/qqmusic/images
com.tencent.qqmusic/files/qqmusic/import
com.tencent.qqmusic/files/qqmusic/lyric
com.tencent.qqmusic/files/qqmusic/lyricposter
com.tencent.qqmusic/files/qqmusic/minialbum
com.tencent.qqmusic/files/qqmusic/minisinger
com.tencent.qqmusic/files/qqmusic/mv
com.tencent.qqmusic/files/qqmusic/offline
com.tencent.qqmusic/files/qqmusic/oltmp
com.tencent.qqmusic/files/qqmusic/qbiz
com.tencent.qqmusic/files/qqmusic/qrc
com.tencent.qqmusic/files/qqmusic/recognize
com.tencent.qqmusic/files/qqmusic/report
com.tencent.qqmusic/files/qqmusic/ringtones
com.tencent.qqmusic/files/qqmusic/screenshot
com.tencent.qqmusic/files/qqmusic/simple-skin
com.tencent.qqmusic/files/qqmusic/singer
com.tencent.qqmusic/files/qqmusic/skin
com.tencent.qqmusic/files/qqmusic/song
com.tencent.qqmusic/files/qqmusic/speedtest
com.tencent.qqmusic/files/qqmusic/splash
com.tencent.qqmusic/files/qqmusic/upgrade
com.tencent.qqmusic/files/qqmusic/welcome
com.tencent.qqmusic/files/recommend
com.tencent.qqmusic/files/tencentvideo.apk
com.tencent.qqmusic/qqmusic/offline
com.tencent.qt.qtl/files/download
com.tencent.reading/files/.omgid/dirs
com.tencent.reading/files/cell
com.tencent.reading/files/data
com.tencent.reading/files/extended
com.tencent.reading/files/favor
com.tencent.reading/files/market
com.tencent.reading/files/news_splash
com.tencent.reading/files/sync
com.tencent.tim/files/arkapp
com.tencent.tmgp.gods/files/downloads
com.tencent.tmgp.gods/files/icon
com.tencent.token/files/log
com.tencent.ttpic/files/cosmetic_mask
com.tencent.ttpic/files/download
com.tencent.ttpic/files/olm/camera
com.tencent.ttpic/files/olm/doodle
com.tencent.ttpic/files/op_fastival_files
com.tencent.ttpic/files/op_lib_files
com.tencent.ttpic/files/op_propagate_files
com.tencent.ttpic/files/op_splash_files
com.tencent.ttpic/files/op_xgirl_files
com.tencent.ttpic/files/opad
com.tencent.ttx5/files/head_image
com.tencent.wblog/http
com.tencent.wehome.lock/crash
com.tencent.zebra/files/download
com.tencent.zebra/files/opad
com.ting.mp3.android/download
com.tmall.wireless/app_common/mru_images
com.tmall.wireless/app_common/nr_persist_images
com.tmall.wireless/app_common/persist_images
com.tmall.wireless/files/atlas-debug
com.tmall.wireless/files/awcn_strategy
com.tmall.wireless/files/carrierdata
com.tmall.wireless/files/com.tmall.wireless
com.tmall.wireless/files/common
com.tmall.wireless/files/debug_storage
com.tmall.wireless/files/ju
com.tmall.wireless/files/music/podcasts
com.tmall.wireless/files/orange_config
com.tmall.wireless/files/plugin
com.tmall.wireless/files/podcasts
com.tmall.wireless/test/test
com.toccata.technologies.general.zombieshoot02a
com.tongcheng.android/files/download
com.tripadvisor.tripadvisor.daodao/files/.hidden
com.tripadvisor.tripadvisor.daodao/files/mapresources/.common
com.tripadvisor.tripadvisor.daodao/files/mapresources/.daystyle
com.tripadvisor.tripadvisor.daodao/files/mapresources/.shaders
com.tripadvisor.tripadvisor.daodao/files/mapresources/daystyle
com.tripadvisor.tripadvisor.daodao/files/mapresources/maps
com.tripadvisor.tripadvisor.daodao/files/mapresources/preinstalledmaps
com.tripadvisor.tripadvisor.daodao/files/mapresources/res
com.tudou.android/files/.local_thumbnail
com.tudou.android/files/awcn_strategy
com.tudou.android/files/offlinead
com.tudou.android/files/photo
com.tudou.android/files/picture
com.tudou.android/files/pictures
com.uc.infoflow/files/awcn_strategy
com.uc.infoflow/files/tnetlogs
com.ucmobile.intl/files/awcn_strategy
com.ucmobile/cache/uil-images
com.ucmobile/cache/video_thumb
com.ucmobile/files/awcn_strategy
com.ucmobile/files/carrierdata
com.ucmobile/homepage
com.ucmobile/myvideo
com.unicom.push/unicom_net.txt
com.viber.voip/files/.icons
com.videogo/files/carrierdata
com.vivo.abe/files/mqttconnection
com.vivo.game/files/mqttconnection
com.vlingo.midas/serial
com.vlingo.midas/testdata
com.wandoujia.phoenix2/files/awcn_strategy
com.wandoujia.phoenix2/files/carrierdata
com.wifi.key/files/awcn_strategy
com.wifi.key/files/pictures/splash
com.xfplay.play/playlists
com.xfplay.play/xfplay
com.xiaomi.market/files/download/apks
com.xiaomi.o2o/files/baichuan/log
com.xiaomi.o2o/files/carrierdata
com.xiaomi.o2o/files/download
com.xiaomi.smarthome/files/miwifi
com.xunlei.downloadprovider/files/awcn_strategy
com.xunlei.downloadprovider/funtime/joke
com.xunlei.downloadprovider/funtime/pic
com.xunlei.downloadprovider/funtime/video
com.xunlei.downloadprovider/req
com.xunlei.downloadprovider/thundercrash
com.xunlei.downloadprovider/xlshare
com.xunlei.kankan/files/downloads
com.xunlei.kankan/funtime/joke
com.xunlei.kankan/funtime/pic
com.xunlei.kankan/thundercrash
com.xunlei.kankan/xlshare
com.xunmeng.pinduoduo/files/awcn_strategy
com.xunmeng.pinduoduo/files/pdd_crash_report
com.yidian.dk/files/carrierdata
com.yidian.xiaomi/files/.update
com.yidian.xiaomi/files/awcn_strategy
com.yixia.videoeditor/files/miaopai/theme
com.yixia.videoeditor/rongcloud
com.youku.pad/files/pictures
com.youku.phone.jinli/files/.local_thumbnail
com.youku.phone/baodownload
com.youku.phone/files/.local_thumbnail
com.youku.phone/files/atlas-debug
com.youku.phone/files/awcn_strategy
com.youku.phone/files/offlinead
com.youku.phone/files/orange_config
com.youku.phone/files/orange_config_content
com.youku.phone/files/photo
com.youku.phone/files/pictures
com.youku.phone/files/youku/offlinedata
com.youku.phone/gameplugins
com.youloft.calendar/files/carrierdata
com.youloft.calendar/gif
com.youloft.calendar/image
com.yuedong.sport/files/carrierdata
com.yulong.android.calendar/files/dcsdk
com.yulong.android.launcher3/files/dcsdk
com.yulong.android.memo/files/dcsdk
com.yulong.android.ota/files/dcsdk
com.yulong.android.security/coolpush
com.yulong.android.xtime/.coolpush
com.yunos.account/files/awcn_strategy
com.yx/haoduo/config
com.yx/jzmob/config
com.yy.yymeet/files/carrierdata
com.ztgame.bob/files/audio
com.ztgame.bob/files/photo
com.ztgame.bob/files/vercache/android
ctrip.android.view/guide
eof
cat $sd/adzw.txt|$xargs_2 -P 80 -I adz0 sh -c "echo /data/data/adz0 >>$sd/adzw_list.txt;chattr -R -i /data/data/adz0 >/dev/null 2>&1;rm -rf /data/data/adz0 2>>$sd/adzw_2_err.txt"
num_2_0=`wc -l $sd/adzw_list.txt|$awk_2 '{print $1}'`
cat $sd/adzw_list.txt >>$sd/adzw_0.txt
wait
cat $sd/adzw.txt|$xargs_2 -P 80 -I adz0 rm -r /data/data/adz0 2>/dev/null
rm -f $sd/adzw.txt $sd/adzw_list.txt && echo "   /data/data/*App*中特定文件夹清理完毕 ！"
unset adz0

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
pansong291.xposed.quickenergy.qiufeng
qmt
QQBrowser
ramdump
setup
SogouReader
[Tt]encent/tbs
ucgamesdk
Ulike
XHS
eof
adzw_ad_num=0
for adz0 in `cat $sd/adzw.txt`
do
   if [[ -d $sd/$adz0 ]]
   then
   chattr -R -i "$sd/$adz0" 2>/dev/null
   chmod -R 777 "$sd/$adz0" 2>/dev/null
   rm -rf "$sd/$adz0"
   touch "$sd/$adz0"
   chmod 000 "$sd/$adz0"
   chattr +i "$sd/$adz0"
   adzw_ad_num=$(($adzw_ad_num+1))
   elif [[ -f $sd/$adz0 && -w $sd/$adz0 ]]
   then
   rm -rf "$sd/$adz0"
   touch "$sd/$adz0"
   chmod 000 "$sd/$adz0"
   chattr +i "$sd/$adz0"
   adzw_ad_num=$(($adzw_ad_num+1))
   fi
done
wait
rm -f $sd/adzw.txt
unset adz0

find /data \( -iname "ad" -o -iname "AdHub" -o -iname "ads" -o -iname "*_ad" -o -iname "*_ads" -o -iname "*_ad_*" -o -iname "ad_*" -o -iname "ads_*" -o -iname "brandad" -o -iname "miad" -o -iname "MiPushLog" -o -iname "msflogs" -o -iname "startupsplash" -o -iname "splash" -o -iname "tbslog" -o -iname ".u" -o -iname ".um" -o -iname ".uuid" -o -iname ".uxx" -o -iname ".vy" -o -iname ".yyy" -o -iname ".zzz" -o -iname "um" -o -iname "uuid" -o -iname "uxx" \) 2>/dev/null|sed -e '/.so/ d' -e '/.sh/ d' -e '/.db/ d' -e '/.xml/ d' -e '/.crc/ d' -e '/com.tencent.tmgp.sgame/ d' -e '/com.tencent.mm\/MicroMsg/ d' >>$sd/adzw_ad.txt

x5tbs_num=0
for x5tbs_1 in `find /data -type d -iname "*Tencent*" 2>/dev/null|sed -e '/com.tencent.tmgp.sgame/ d'`
do
  for x5tbs_2 in `find $x5tbs_1 \( -iname "app_tbs" -o -iname "app_tbs_64" -o -iname "x5.backup*" -o -iname "x5.tbs.org*" \)`;do
    if [[ -s $x5tbs_2 ]];then
      chattr -R -i "$x5tbs_2" 2>/dev/null
      chmod -R 777 "$x5tbs_2" 2>/dev/null
      rm -rf "$x5tbs_2"
      touch "$x5tbs_2"
      chmod 000 "$x5tbs_2"
      [[ $? == "0" ]] && x5tbs_num=$(($x5tbs_num+1))
    fi
  done
done
echo "   已干掉QQ、微信的X5内核，共$x5tbs_num个文件 ！"
unset x5tbs_1
unset x5tbs_2
unset x5tbs_num
echo -e "\033[1m—————————————————————————————————————————\033[0m"

echo "   开始从根目录起搜索文件夹，稍等..."
{ find / \( -path /sys -o -path /proc \) -prune -o -type d \( -iname "*_log" -o\
 -iname "*_logs" -o\
 -iname "*_report" -o\
 -iname "*_temp" -o\
 -iname "*_tmp" -o\
 -iname "*cache" -o\
 -iname "*crash" -o\
 -iname "*-log" -o\
 -iname "*-logs" -o\
 -iname "*microthumbnailfile" -o\
 -iname "*-temp" -o\
 -iname "*-tmp" -o\
 -iname ".log" -o\
 -iname ".*_thumbnail" -o\
 -iname ".td-3" -o\
 -iname ".tdck" -o\
 -iname "*.test" -o\
 -iname ".thumbnail" -o\
 -iname ".thumbnails" -o\
 -iname ".temp" -o\
 -iname ".tmfs" -o\
 -iname ".tmp" -o\
 -iname "album*" -o\
 -iname "baidu" -o\
 -iname "bugreports" -o\
 -iname "crashdata" -o\
 -iname "dcsdk" -o\
 -iname "debug" -o\
 -iname "log" -o\
 -iname "logs" -o\
 -iname "MiPushLog" -o\
 -iname "onelog" -o\
 -iname "sqltrace" -o\
 -iname "temp" -o\
 -iname "thumb*" -o\
 -iname "tmp" -o\
 -iname "tombstones" \) 2>/dev/null|sed -e '/\/sys/ d' -e '/\/proc/ d' -e '/\/com.tencent.tmgp.sgame/ d' -e '/.auth_cache/ d' -e '/yttrium_code_cache/ d' >>$sd/adzw_1.txt;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_1.txt|$xargs_2 -0 -P 80 -I deldir_1 sh -c "rm -rf \"deldir_1\" 2>>$sd/adzw_1_err.txt";
sleep 3s;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_1.txt|$xargs_2 -0 -P 80 -I deldir_1 sh -c "rm -r \"deldir_1\" 2>/dev/null";} &
wait   # 避免同时与/data进行后台搜索清理

echo "   开始在data中搜索文件夹，稍等..."
{ find /data -type d \( -iname "*_bak" -o\
 -iname "*_debug" -o\
 -iname "*_info" -o\
 -iname "*cache*" -o\
 -iname "*log" -o\
 -iname "*log-*" -o\
 -iname "*log_*" -o\
 -iname "*logic" -o\
 -iname "*logs" -o\
 -iname "*logs-*" -o\
 -iname "*logs_*" -o\
 -iname "*push" -o\
 -iname "*temp" -o\
 -iname "*tmp" -o\
 -iname "*tmps" -o\
 -iname ".*info" -o\
 -iname ".*infos" -o\
 -iname ".acs" -o\
 -iname ".advertise" -o\
 -iname ".android" -o\
 -iname ".androidsystem" -o\
 -iname ".aoe" -o\
 -iname ".appcenter" -o\
 -iname ".appcenterwebbuffer*" -o\
 -iname ".application" -o\
 -iname ".ark_download" -o\
 -iname ".astable" -o\
 -iname ".attachments" -o\
 -iname ".avatar" -o\
 -iname ".awp" -o\
 -iname ".babylon" -o\
 -iname ".bimm" -o\
 -iname ".bmob" -o\
 -iname ".book" -o\
 -iname ".bottomtabs" -o\
 -iname ".cc" -o\
 -iname ".ccdid" -o\
 -iname ".ccvid" -o\
 -iname ".channelid" -o\
 -iname ".chap" -o\
 -iname ".chap_l" -o\
 -iname ".cloud" -o\
 -iname ".cm_restart_record" -o\
 -iname ".composer" -o\
 -iname ".debug" -o\
 -iname ".desc_icon" -o\
 -iname ".did" -o\
 -iname ".discovery" -o\
 -iname ".dlprovider" -o\
 -iname ".down_c" -o\
 -iname ".download" -o\
 -iname ".downloadconf" -o\
 -iname ".drm" -o\
 -iname ".dthumb" -o\
 -iname ".duid" -o\
 -iname ".dzh" -o\
 -iname ".effect" -o\
 -iname ".emoji" -o\
 -iname ".emoqface" -o\
 -iname ".emotionsm" -o\
 -iname ".estrongs" -o\
 -iname ".events" -o\
 -iname ".favorite" -o\
 -iname ".feedback" -o\
 -iname ".fg" -o\
 -iname ".freshword" -o\
 -iname ".fssingerres" -o\
 -iname "FTS_BizCacheObj" -o\
 -iname ".gift" -o\
 -iname ".hcdnlivenet.ini" -o\
 -iname ".hiidosdk" -o\
 -iname ".icmweather" -o\
 -iname ".icon" -o\
 -iname ".iconbig" -o\
 -iname ".idm" -o\
 -iname ".im" -o\
 -iname ".image" -o\
 -iname ".images" -o\
 -iname ".interest" -o\
 -iname ".irsmonitorsdk" -o\
 -iname ".jars" -o\
 -iname ".jdd" -o\
 -iname ".jds" -o\
 -iname "krsdk" -o\
 -iname ".kspdf" -o\
 -iname ".kugouid" -o\
 -iname ".lm_device" -o\
 -iname ".locationicon" -o\
 -iname ".lockstyle_config" -o\
 -iname ".mcs" -o\
 -iname ".mergetheme" -o\
 -iname ".mn_" -o\
 -iname ".mtdfp" -o\
 -iname ".mtxx" -o\
 -iname ".MYXJ" -o\
 -iname ".n_a" -o\
 -iname ".n_b" -o\
 -iname ".n_c" -o\
 -iname ".n_d" -o\
 -iname ".ndfsc" -o\
 -iname ".nearby_flower" -o\
 -iname ".nvtts" -o\
 -iname ".o_a" -o\
 -iname ".o_b" -o\
 -iname ".o_c" -o\
 -iname ".o_d" -o\
 -iname ".oaidsystemconfig" -o\
 -iname ".op" -o\
 -iname ".openfail" -o\
 -iname ".pendant" -o\
 -iname ".plugin" -o\
 -iname ".poco" -o\
 -iname ".portrait" -o\
 -iname ".portraitnew" -o\
 -iname ".pre" -o\
 -iname ".prenew" -o\
 -iname ".profile" -o\
 -iname ".qiyi" -o\
 -iname ".qm_guid" -o\
 -iname ".qmt" -o\
 -iname ".qqchess" -o\
 -iname ".record" -o\
 -iname ".recordsample" -o\
 -iname "rs-" -o\
 -iname ".sandbox" -o\
 -iname ".search" -o\
 -iname ".shared" -o\
 -iname ".shop" -o\
 -iname ".shop_assit" -o\
 -iname ".signaturetemplate" -o\
 -iname ".singerres" -o\
 -iname ".smartbiz" -o\
 -iname ".snggame" -o\
 -iname ".snggamemsg" -o\
 -iname ".splash" -o\
 -iname ".ssjjsy" -o\
 -iname ".statistic" -o\
 -iname ".statuses" -o\
 -iname ".story" -o\
 -iname ".sym" -o\
 -iname ".sys" -o\
 -iname ".sys_prefer" -o\
 -iname ".systemconfig" -o\
 -iname ".tad" -o\
 -iname ".tbs" -o\
 -iname ".tcookieid" -o\
 -iname ".test" -o\
 -iname ".theme_net" -o\
 -iname ".thumbcache" -o\
 -iname ".thumbcache_idx_[0-9]*" -o\
 -iname ".timebox" -o\
 -iname ".tmfs" -o\
 -iname ".tmpdir" -o\
 -iname ".tmsdual" -o\
 -iname ".tomb" -o\
 -iname ".ttcryptofile" -o\
 -iname ".turing.dat" -o\
 -iname ".turingdebug" -o\
 -iname ".txlauncher" -o\
 -iname ".ufs" -o\
 -iname ".update" -o\
 -iname ".upgrade" -o\
 -iname ".userreturn" -o\
 -iname ".usex" -o\
 -iname ".uudid" -o\
 -iname ".vdevdir" -o\
 -iname ".vivo" -o\
 -iname ".webapp" -o\
 -iname ".weibo_chat" -o\
 -iname ".weibo_pic" -o\
 -iname ".weibo_pic_edit_new" -o\
 -iname ".weibo_pic_new" -o\
 -iname ".widget" -o\
 -iname ".yd_speech" -o\
 -iname ".zp" -o\
 -iname ".zycl" -o\
 -iname ".zzid.secure" -o\
 -iname ".zzqid.secure" -o\
 -iname ".zzz" -o\
 -iname "__macosx" -o\
 -iname "_chorus" -o\
 -iname "_hd" -o\
 -iname "_mel" -o\
 -iname "_music" -o\
 -iname "_ori_mp3" -o\
 -iname "_play_zrce" -o\
 -iname "_slt" -o\
 -iname "_ssohd" -o\
 -iname "_thd" -o\
 -iname "_zrce" -o\
 -iname "accompaniment" -o\
 -iname "acct_head" -o\
 -iname "achievement" -o\
 -iname "action" -o\
 -iname "activity" -o\
 -iname "activity_banner" -o\
 -iname "addrmgr" -o\
 -iname "adesk_livewallaper" -o\
 -iname "adsapp" -o\
 -iname "adv.db" -o\
 -iname "aggregate" -o\
 -iname "album" -o\
 -iname "albumthumbs" -o\
 -iname "amimemoji" -o\
 -iname "anr" -o\
 -iname "anrsnap" -o\
 -iname "aoe" -o\
 -iname "app_accs" -o\
 -iname "app_blog_*" -o\
 -iname "app_dxad" -o\
 -iname "app_tbs" -o\
 -iname "app_tbs_64" -o\
 -iname "app_tbs_common_share" -o\
 -iname "app_webview" -o\
 -iname "app_x5webview" -o\
 -iname "appicon" -o\
 -iname "appsearch" -o\
 -iname "appseller" -o\
 -iname "AppTimer" -o\
 -iname "aps" -o\
 -iname "ar_feature" -o\
 -iname "ar_map" -o\
 -iname "ar_model" -o\
 -iname "aray" -o\
 -iname "ark_download" -o\
 -iname "arkapk" -o\
 -iname "arkapp" -o\
 -iname "artist" -o\
 -iname "ashe" -o\
 -iname "at" -o\
 -iname "atadspgresu.txt" -o\
 -iname "attachment" -o\
 -iname "attitude_pic" -o\
 -iname "autodownload" -o\
 -iname "autonavi" -o\
 -iname "aweme_monitor" -o\
 -iname "background" -o\
 -iname "backup" -o\
 -iname "backups" -o\
 -iname "baidu" -o\
 -iname "baidumapsdk" -o\
 -iname "baidupanosdk" -o\
 -iname "banner" -o\
 -iname "bcs" -o\
 -iname "bdbook" -o\
 -iname "bdmsa_gr" -o\
 -iname "bdmusic" -o\
 -iname "bdother" -o\
 -iname "bdpicture" -o\
 -iname "bdvideo" -o\
 -iname "beam" -o\
 -iname "behaviour_report" -o\
 -iname "betasdk" -o\
 -iname "bigattachment" -o\
 -iname "bigbanner" -o\
 -iname "bigpictrue" -o\
 -iname "bisheng.download" -o\
 -iname "bizimg" -o\
 -iname "bk" -o\
 -iname "bkd" -o\
 -iname "bless" -o\
 -iname "bookmark" -o\
 -iname "boss" -o\
 -iname "boutique" -o\
 -iname "breakpointinfo" -o\
 -iname "btm_adv" -o\
 -iname "bubble" -o\
 -iname "buckle" -o\
 -iname "bufferads" -o\
 -iname "businesscard" -o\
 -iname "bytedance" -o\
 -iname "ByteDownload" -o\
 -iname "cllamapsdk" -o\
 -iname "com_tencent_mm:*" -o\
 -iname "debug" -o\
 -iname "debug_*" -o\
 -iname "dump" -o\
 -iname "easou_book" -o\
 -iname "eup" -o\
 -iname "handler" -o\
 -iname "jsmcc" -o\
 -iname "Local Storage" -o\
 -iname "minidump" -o\
 -iname "newsimage" -o\
 -iname "online.*" -o\
 -iname "pending" -o\
 -iname "pushsdk" -o\
 -iname "Session Storage" -o\
 -iname "sns" -o\
 -iname "ssjjsy" -o\
 -iname "statistic" -o\
 -iname "storage" -o\
 -iname "tad" -o\
 -iname "tbs" -o\
 -iname "ted" -o\
 -iname "templates" -o\
 -iname "test_writable" -o\
 -iname "tmassistantsdk" -o\
 -iname "tmfs" -o\
 -iname "trace" -o\
 -iname "turbonet" -o\
 -iname "turingdebug" -o\
 -iname "uapp" -o\
 -iname "ucwa" -o\
 -iname "vipshop" -o\
 -iname "watchdog" -o\
 -iname "webview_tmpl" -o\
 -iname "welcome" -o\
 -iname "wxafiles" -o\
 -iname "wxanewfiles" -o\
 -iname "xlogtest_writable" \) 2>/dev/null|sed -e '/\/com.tencent.tmgp.sgame/ d' -e '/app_clock_bak/ d' -e '/.auth_cache/ d' -e '/yttrium_code_cache/ d' >>$sd/adzw_2.txt;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_2.txt|$xargs_2 -0 -P 80 -I deldir_21 sh -c "rm -rf \"deldir_21\" 2>>$sd/adzw_2_errtemp.txt";
sleep 3s;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_2.txt|$xargs_2 -0 -P 80 -I deldir_21 sh -c "rm -r \"deldir_21\" 2>/dev/null";
sleep 3s;
$awk_2 -F "'" '{print $3}' $sd/adzw_2_errtemp.txt|sed -e '/\/data\/media\/0/ d' -e '/\/data\/user_de\/0\/com.android.systemui/ d' -e '/\/data\/user_de\/0\/com.miui.home/ d' -e '/\/sbin\/.magisk\/mirror\/data\/media\/0/ d' -e '/\/sbin\/.magisk\/mirror\/data\/user_de\/0\/com.android.systemui/ d' -e '/\/sbin\/.magisk\/mirror\/data\/user_de\/0\/com.miui.home/ d'|$xargs_2 -P 80 -I deldir_22 sh -c "chattr -R -i \"deldir_22\" >/dev/null 2>&1;rm -rf \"deldir_22\" 2>>$sd/adzw_2_err.txt";} &
sleep 3s

echo "   开始在sd卡中搜索文件夹，稍等..."
{ find $sd -type d \( -iname "*login" -o\
 -iname "*story" -o\
 -iname ".trashBin" -o\
 -iname ".wx" -o\
 -iname "backup" -o\
 -iname "backups" -o\
 -iname "mta*" -o\
 -iname "pcdn" -o\
 -iname "shadowplugin*" -o\
 -iname "tbs" -o\
 -iname "uploader" \) 2>/dev/null >>$sd/adzw_3.txt;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_3.txt|$xargs_2 -0 -P 80 -I deldir_3 sh -c "rm -rf \"deldir_3\" 2>>$sd/adzw_3_err.txt";
sleep 3s;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_3.txt|$xargs_2 -0 -P 80 -I deldir_3 sh -c "rm -r \"deldir_3\" 2>/dev/null";} &
sleep 3s

echo "   开始从根目录起搜索文件，稍等..."
{ find / \( -path /sys -o -path /proc \) -prune -o -type f \( -iname "*.old" -o\
 -iname "*.temp" -o\
 -iname "*.tmfs" -o\
 -iname "*.tmp" -o\
 -iname "*_log" -o\
 -iname "*_log*.txt" -o\
 -iname "*error" -o\
 -iname "*log" -o\
 -iname "*logs" -o\
 -iname "*log.lock" -o\
 -iname "*log.txt" -o\
 -iname "*log{0..9}.txt" -o\
 -iname "*logs" -o\
 -iname "log_*.txt" -o\
 -iname "logs_*.txt" -o\
 -iname "Thumbs.db" -o\
 -iname "x5.backup*" -o\
 -iname "x5.tbs.org*" \) 2>/dev/null|sed -e '/\/sys/ d' -e '/\/proc/ d' -e '/\/com.tencent.tmgp.sgame/ d' >>$sd/adzw_4.txt;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_4.txt|$xargs_2 -0 -P 80 -I delfile_41 sh -c "rm -rf \"delfile_41\" 2>>$sd/adzw_4_err.txt";
sleep 3s;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_4.txt|$xargs_2 -0 -P 80 -I delfile_41 sh -c "rm -r \"delfile_41\" 2>/dev/null";} &
sleep 5s

echo "   开始在data中搜索文件，稍等..."
{ find /data -type f \( -iname "*cache*" -o\
 -iname "*_history" -o\
 -iname "*_ready.statistic" -o\
 -iname "*_list.txt" -o\
 -iname "*.bak" -o\
 -iname "*.backup" -o\
 -iname "*.backups" -o\
 -iname "*.tlog" -o\
 -iname "*.trace" -o\
 -iname "*info.txt" -o\
 -iname "*log" -o\
 -iname "*logs" -o\
 -iname "*test_writable" -o\
 -iname "._.Trashes" -o\
 -iname ".common" -o\
 -iname ".spotlight*" -o\
 -iname ".DS_Store" -o\
 -iname ".fseventsd" -o\
 -iname ".tim" -o\
 -iname "alsn.db" -o\
 -iname "external.db-shm" -o\
 -iname "external.db-wal" -o\
 -iname "mistat.db-shm" -o\
 -iname "mistat.db-wal" -o\
 -iname "state-*.bin.bak" -o\
 -iname "variations_seed_new" \) 2>/dev/null|sed -e '/\/Books\/Soushu/ d' -e '/\/com.tencent.tmgp.sgame/ d' -e '/\/lib\// d' -e '/\/lib64\// d' -e '/.so/ d' >>$sd/adzw_5.txt;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_5.txt|$xargs_2 -0 -P 80 -I delfile_51 sh -c "rm -rf \"delfile_51\" 2>>$sd/adzw_5_errtemp.txt";
sleep 3s;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_5.txt|$xargs_2 -0 -P 80 -I delfile_51 sh -c "rm -r \"delfile_51\" 2>/dev/null";
sleep 3s;
$awk_2 -F "'" '{print $3}' $sd/adzw_5_errtemp.txt|sed -e '/\/data\/media\/0/ d' -e '/\/data\/user_de\/0\/com.android.systemui/ d' -e '/\/data\/user_de\/0\/com.miui.home/ d' -e '/\/sbin\/.magisk\/mirror\/data\/media\/0/ d' -e '/\/sbin\/.magisk\/mirror\/data\/user_de\/0\/com.android.systemui/ d' -e '/\/sbin\/.magisk\/mirror\/data\/user_de\/0\/com.miui.home/ d'|$xargs_2 -P 80 -I delfile_52 sh -c "chattr -R -i \"delfile_52\" >/dev/null 2>&1;rm -rf \"delfile_52\" 2>>$sd/adzw_5_err.txt";} &
sleep 3s;
{ for adzw_53 in `find /data -type d \( -iname "*_databases" -o -iname "databases" -o -iname "files" -o -iname "shared_prefs" -o -iname "system" \) 2>/dev/null|sed -e '/com.android.deskclock/ d'`;
do
  find $adzw_53 -type f \( -iname "*-shm" -o -iname "*-wal" -o -iname "*-journal" \) 2>/dev/null|$xargs_2 -P 80 -I delfile_53 sh -c "echo \"delfile_53\" >>$sd/adzw_5.txt;chattr -R -i \"delfile_53\";rm -rf \"delfile_53\" 2>>$sd/adzw_5_err.txt";
done;} &

echo "   开始在sd卡中搜索文件，稍等..."
{ find $sd -type f \( -iname "*.[0-9]" -o\
 -iname "*.alipaypng" -o\
 -iname "*.chunk.css" -o\
 -iname "*.chunk.js" -o\
 -iname "*.kpg" -o\
 -iname "._*" -o\
 -iname ".mid.txt" -o\
 -iname ".mn*" -o\
 -iname ".qqq" -o\
 -iname ".sss" -o\
 -iname "lcfp" -o\
 -iname "lcfp.lock" \) 2>/dev/null >>$sd/adzw_6.txt;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_6.txt|$xargs_2 -0 -P 80 -I delfile_61 sh -c "rm -rf \"delfile_61\" 2>>$sd/adzw_6_err.txt";
sleep 3s;
$awk_2 -v FS='\n' -v ORS='\0' '{print $0}' $sd/adzw_6.txt|$xargs_2 -0 -P 80 -I delfile_61 sh -c "rm -r \"delfile_61\" 2>/dev/null";} &

echo "   开始进行QQ的JPG、MP4清理，稍等..."
$find_2 $sd/[Tt]encent/QQLite -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &
$find_2 $sd/[Tt]encent/MobileQQ -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &
$find_2 $sd/Android/data/com.tencent.mobileqq -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &
$find_2 $sd/Android/data/com.tencent.qqlite -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &

echo "   开始进行微信的JPG、MP4清理，稍等..."
$find_2 $sd/[Tt]encent/MicroMsg -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &
$find_2 /data/data/com.tencent.mm/MicroMsg -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &
$find_2 $sd/Android/data/com.tencent.mm/MicroMsg -type f \( -iname "*.jpg" -o -iname "*.mp4" \) -print0 2>/dev/null | $xargs_2 -0 -P 80 rm -rf &>/dev/null &

echo "   开始进行MIUI的JPG、PNG清理，稍等..."
$find_2 $sd/MIUI \( -atime +5 -o -mtime +5 \) -type f \( -iname "*.png" -o -iname "*.jpg" \) -print0 2>/dev/null |sed -e '/\/MIUI\/theme\/.data/ d' | $xargs_2 -0 -P 80 rm -rf &>/dev/null &

echo "   开始清理SD卡中影音图片小文件，稍等..."
echo "   *****可能会删除大量游戏资源文件******"
smallfile_1=`$find_2 $sd \( -path $sd/Books -o -path $sd/DCIM -o -path $sd/Download -o -path $sd/Pictures -o -path $sd/WechatXposed \) -prune -o \( -atime +15 -o -mtime +15 \) -type f -size -300k 2>/dev/null|sed -e '/.nomedia/ d' -e '/\/0\/Books/ d' -e '/\/0\/DCIM/ d' -e '/\/0\/Download/ d' -e '/\/0\/Pictures/ d' -e '/\/0\/WechatXposed/ d' -e '/\/com.tencent.tmgp.sgame/ d' -e '/\/MIUI\/theme\/.data/ d'`
smallfile_2=`$find_2 /data/data \( -atime +15 -o -mtime +15 \) -type f -size -300k 2>/dev/null|sed -e '/.nomedia/ d'`
for smallfile_3 in $smallfile_1 $smallfile_2;
do
  { smallfile_4=`file "$smallfile_3" 2>/dev/null | $awk_2 '{print $2}'`;
  [[ $smallfile_4 == "empty" || $smallfile_4 == "BMP" || $smallfile_4 == "GIF" || $smallfile_4 == "ICO" || $smallfile_4 == "JPEG" || $smallfile_4 == "JPG" || $smallfile_4 == "PCX" || $smallfile_4 == "PNG" || $smallfile_4 == "SWF" || $smallfile_4 == "SVG" || $smallfile_4 == "TIF" || $smallfile_4 == "TIFF" || $smallfile_4 == "WEBP" || $smallfile_4 == "WMF" || $smallfile_4 == "3GP" || $smallfile_4 == "AAC" || $smallfile_4 == "ASF" || $smallfile_4 == "ASX" || $smallfile_4 == "AVI" || $smallfile_4 == "FLAC" || $smallfile_4 == "FLV" || $smallfile_4 == "MKV" || $smallfile_4 == "MPEG" || $smallfile_4 == "MP3" || $smallfile_4 == "MP4" || $smallfile_4 == "WMV" ]] && (rm -f \"$smallfile_3\" 1>/dev/null 2>>$sd/adzw_7_err.txt;[[ $? == "0" ]] && echo $smallfile_3 >>$sd/adzw_7.txt);} &
done

/system/bin/pm list packages | $awk_2 -F ':' '{print $2}' >$sd/adzw_allapp_1.txt
find /system -type d \( -iname "app" -o -iname "*-app" \) 2>/dev/null|$xargs_2 -L 1 ls -lA|grep "^d"|$awk_2 '{print $9}'>>$sd/adzw_allapp_1.txt
find /vendor -type d \( -iname "app" -o -iname "*-app" \) 2>/dev/null|$xargs_2 -L 1 ls -lA|grep "^d"|$awk_2 '{print $9}'>>$sd/adzw_allapp_1.txt
sort -n $sd/adzw_allapp_1.txt | uniq >$sd/adzw_allapp_2.txt
find_chear_apppath=(/data/app /data/data /data/user_de/0 $sd/Android/data)
for chear_apppath in ${find_chear_apppath[*]}
do
  { ls -lA $chear_apppath |grep "^d"|$awk_2 '{print $9}'|$awk_2 -F '[ -]' '{print $1}'>$sd/adzw${chear_apppath//\//_}.txt;
  for chear_appname in `cat $sd/adzw${chear_apppath//\//_}.txt`;do
    [[ ! `grep -ix "$chear_appname" $sd/adzw_allapp_2.txt` ]] && (/system/bin/pm uninstall $chear_appname &>/dev/null;sleep 0.5s;chattr -R -i $chear_apppath/$chear_appname &>/dev/null;rm -rf \"$chear_apppath/$chear_appname\" 1>/dev/null 2>>$sd/adzw_8_err.txt;[[ $? == "0" ]] && echo $chear_apppath/$chear_appname >>$sd/adzw_8.txt);
  done;} &
done

rm -rf /data/crashdata/* &>/dev/null
rm -rf /data/dalvik-cache/* &>/dev/null
rm -rf /data/tombstones/* &>/dev/null
rm -rf /data/local/* &>/dev/null   # 系统跟踪记录
rm -rf /data/system/dropbox/* &>/dev/null   # DropBox的日志
rm -rf /data/system/package_cache/* &>/dev/null
rm -rf /data/system/procstats/* &>/dev/null   # 进程统计
rm -rf /data/system/usagestats/* &>/dev/null   # App启动统计信息
rm -rf /data/system_ce/0/recent_images/* &>/dev/null
rm -rf /data/system_ce/0/recent_tasks/* &>/dev/null  # "最近任务"缓存
rm -rf /data/system_ce/0/snapshots/* &>/dev/null
rm -rf /dev/fscklogs/* &>/dev/null  # 应用程序崩溃、内核日志记录等
rm -rf /idd/crashdata/* &>/dev/null
rm -rf /sys/kernel/debug/* &>/dev/null
rm -rf /proc/sys/debug/* &>/dev/null
sleep 3s
rm -r /data/crashdata/* &>/dev/null
rm -r /data/dalvik-cache/* &>/dev/null
rm -r /data/tombstones/* &>/dev/null
rm -r /data/local/* &>/dev/null   # 系统跟踪记录
rm -r /data/system/dropbox/* &>/dev/null   # DropBox的日志
rm -r /data/system/package_cache/* &>/dev/null
rm -r /data/system/procstats/* &>/dev/null   # 进程统计
rm -r /data/system/usagestats/* &>/dev/null   # App启动统计信息
rm -r /data/system_ce/0/recent_images/* &>/dev/null
rm -r /data/system_ce/0/recent_tasks/* &>/dev/null  # "最近任务"缓存
rm -r /data/system_ce/0/snapshots/* &>/dev/null
rm -r /dev/fscklogs/* &>/dev/null  # 应用程序崩溃、内核日志记录等
rm -r /idd/crashdata/* &>/dev/null
rm -r /sys/kernel/debug/* &>/dev/null
rm -r /proc/sys/debug/* &>/dev/null

$find_2 /data/misc/profiles -type f -iname "primary.prof" 2>/dev/null | $xargs_2 -P 80 -I delfile_81 sh -c "echo \"\">delfile_81"
$find_2 /data \( -iname "*cache*" -o -iname "*.log" -o -iname "*.logs" \) -print0 | sed -e '/.auth_cache/ d' -e '/yttrium_code_cache/ d' -e '/\/lib\// d' -e '/\/lib64\// d' -e '/.so/ d' | $xargs_2 -0 -P 80 -n 20 rm -rf &>/dev/null;
wait;

[[ -s $sd/adzw_ad.txt ]] && while read adz0
do
  if [[ -e $adz0 ]];then
    chattr -R -i $adz0 >/dev/null 2>&1
    chmod -R 777 $adz0 >/dev/null 2>&1
    rm -rf $adz0
  fi
  mkdir -p ${adz0%/*}
  touch $adz0 2>/dev/null
  chmod 000 $adz0 2>/dev/null
  chattr +i $adz0 2>/dev/null
  [[ $? == "0" ]] && adzw_ad_num=$(($adzw_ad_num+1))
done < $sd/adzw_ad.txt
unset adz0

echo "   开始进行data/data和sd卡空文件(夹)清理，稍等..."
[[ $find_1 == "1" ]] && { start_ffile_num=`$find_2 $sd -type f -empty ! -iname ".nomedia" 2>/dev/null|wc -l`;start_fdir_num=`$find_2 /data -type d -empty 2>/dev/null|wc -l`;}
if [[ $find_1 == "1" ]]
then
  $find_2 $sd -type f -empty ! -iname ".nomedia" -delete &>/dev/null
else
  for ffile in `find $sd -type f -size 0c|sed -e '/.nomedia/ d'`;do
    if [[ ! -s "$ffile" ]];then
      rm -rf "$ffile" &>/dev/null
      [[ $? == "0" ]] && ffile_num=$(($ffile_num+1))
    fi
  done
fi
for z in {1..3}
do
  if [[ $find_1 == "1" ]];then
    $find_2 /data -type d -empty -delete &>/dev/null
  else
   { for fdir_1 in `find /data -type d`;do
      empty_dir_1=$(ls -A "$fdir_1" 2>/dev/null);
      if [[ -z "$empty_dir_1" ]];then
        rm -rf "$fdir_1" &>/dev/null;
        [[ $? == "0" ]] && fdir_num=$(($fdir_num+1));
        echo $fdir_num >>$sd/adzw_emptydir.txt;
      fi;
    done;}
  fi
  sleep 3s;
done
[[ $find_1 == "1" ]] && { end_ffile_num=`$find_2 $sd -type f -empty ! -iname ".nomedia" 2>/dev/null|wc -l`;end_fdir_num=`$find_2 /data -type d -empty 2>/dev/null|wc -l`;let ffile_num="start_ffile_num - end_ffile_num";let fdir_num="start_fdir_num - end_fdir_num";}
[[ $find_1 == "2" ]] && fdir_num=`cat $sd/adzw_emptydir.txt|$awk_2 '{sum +=$1};END {print sum}'`
[[ ! -d $sd/DCIM ]] && mkdir -p $sd/DCIM &>/dev/null
[[ ! -d $sd/Download ]] && mkdir -p $sd/Download &>/dev/null
[[ ! -d $sd/Pictures/WeiXin ]] && mkdir -p $sd/Pictures/WeiXin &>/dev/null
[[ ! -d $sd/Android/data/com.tencent.mm/MicroMsg/Download ]] && mkdir -p $sd/Android/data/com.tencent.mm/MicroMsg/Download &>/dev/null
echo -e "\033[1m—————————————————————————————————————————\033[0m"

wait;endtime=`date +%s`
for sort_uniq in `ls $sd/adzw_*.txt`
do
  sed -i -e '/No such/ d' -e '/command not found/ d' $sort_uniq
  sort -n $sort_uniq | uniq >$sd/adzw_sort.txt
  mv -f $sd/adzw_sort.txt $sort_uniq
done
[[ ! -f $sd/adzw_1_err.txt ]] && num_1_err=0 || num_1_err=`wc -l $sd/adzw_1_err.txt|$awk_2 '{print $1}'`
[[ ! -f $sd/adzw_2_err.txt ]] && num_2_err=0 || num_2_err=`wc -l $sd/adzw_2_err.txt|$awk_2 '{print $1}'`
[[ ! -f $sd/adzw_3_err.txt ]] && num_3_err=0 || num_3_err=`wc -l $sd/adzw_3_err.txt|$awk_2 '{print $1}'`
[[ ! -f $sd/adzw_4_err.txt ]] && num_4_err=0 || num_4_err=`wc -l $sd/adzw_4_err.txt|$awk_2 '{print $1}'`
[[ ! -f $sd/adzw_5_err.txt ]] && num_5_err=0 || num_5_err=`wc -l $sd/adzw_5_err.txt|$awk_2 '{print $1}'`
[[ ! -f $sd/adzw_6_err.txt ]] && num_6_err=0 || num_6_err=`wc -l $sd/adzw_6_err.txt|$awk_2 '{print $1}'`
[[ ! -f $sd/adzw_1.txt ]] && num_1=0 || let num_1="`wc -l $sd/adzw_1.txt|$awk_2 '{print $1}'` - num_1_err / 2"
[[ ! -f $sd/adzw_2.txt && $num_2_0 ]] && num_2=0 || let num_2="`wc -l $sd/adzw_2.txt|$awk_2 '{print $1}'` - num_2_err / 2 + num_2_0"
[[ ! -f $sd/adzw_3.txt && $num_3_0 ]] && num_3=0 || let num_3="`wc -l $sd/adzw_3.txt|$awk_2 '{print $1}'` - num_3_err / 2 + num_3_0"
[[ ! -f $sd/adzw_4.txt ]] && num_4=0 || let num_4="`wc -l $sd/adzw_4.txt|$awk_2 '{print $1}'` - num_4_err"
[[ ! -f $sd/adzw_5.txt ]] && num_5=0 || let num_5="`wc -l $sd/adzw_5.txt|$awk_2 '{print $1}'` - num_5_err"
[[ ! -f $sd/adzw_6.txt ]] && num_6=0 || let num_6="`wc -l $sd/adzw_6.txt|$awk_2 '{print $1}'` - num_6_err"
[[ ! -f $sd/adzw_7.txt ]] && num_7=0 || num_7="`wc -l $sd/adzw_7.txt|$awk_2 '{print $1}'`"
[[ ! -f $sd/adzw_8.txt ]] && num_8=0 || num_8="`wc -l $sd/adzw_8.txt|$awk_2 '{print $1}'`"
end_used_allsys=`df /apex /cache /cust /data /dev /metadata /mnt /sys /system /vendor 2>/dev/null|$awk_2 'NR!=1 {used+=$3}END{used=used/1024;print used}' 2>/dev/null`
end_used_data=`du -smL /data/ 2>/dev/null|$awk_2 '{print $1}' 2>/dev/null`
end_used_sd=`du -smL $sd/ 2>/dev/null|$awk_2 '{print $1}' 2>/dev/null`
end_used_sdandro=`du -smL $sd/Android/ 2>/dev/null|$awk_2 '{print $1}' 2>/dev/null`
used_allsys=`$awk_2 'BEGIN{print('$start_used_allsys' - '$end_used_allsys')}'`
used_data=`$awk_2 'BEGIN{print('$start_used_data' - '$end_used_data')}'`
used_sd=`$awk_2 'BEGIN{print('$start_used_sd' - '$end_used_sd')}'`
used_sdandro=`$awk_2 'BEGIN{print('$start_used_sdandro' - '$end_used_sdandro')}'`

yes_module(){
echo "   ****** FileClear_for_ZW 执行成功 ******" >>$sd/FileClear_zw_$nowtime.txt
echo "   **** 结束时间：`date +"%Y-%m-%d %T"` ****" >>$sd/FileClear_zw_$nowtime.txt
echo "" >>$sd/FileClear_zw_$nowtime.txt
echo "     本次运行时间:$(( endtime-starttime ))秒，共清理${used_allsys}MB；其中" >>$sd/FileClear_zw_$nowtime.txt
echo "       data分区清理了`$awk_2 'BEGIN{print('$used_data' - '$used_sd')}'`MB(不含sd卡)" >>$sd/FileClear_zw_$nowtime.txt
echo "       sd卡清理了`$awk_2 'BEGIN{print('$used_sd' - '$used_sdandro')}'`MB(不含Android文件夹)" >>$sd/FileClear_zw_$nowtime.txt
echo "       Android文件夹清理了${used_sdandro}MB" >>$sd/FileClear_zw_$nowtime.txt
echo "" >>$sd/FileClear_zw_$nowtime.txt
echo "" >>$sd/FileClear_zw_$nowtime.txt
sed -i "s/^FileClear_logname.*/FileClear_logname=FileClear_zw_$nowtime.txt/g" /data/adb/modules/zw_fileclear/service.sh
sed -i "s/^Runj11time.*/Runj11time=$endtime/g" /data/adb/modules/zw_fileclear/service.sh
}

no_module(){
[[ $num_4 != "0" ]] && echo "   已全盘删除$num_4个文件"
[[ $num_1 != "0" ]] && echo "   已全盘删除$num_1个文件夹"
[[ $num_6 != "0" ]] && echo "   已在sd卡中删除$num_6个文件"
[[ $num_3 != "0" ]] && echo "   已在sd卡中删除$num_3个文件夹"
[[ $num_7 != "0" ]] && echo "   已在sd卡中删除$num_7个影音图片小文件"
[[ $num_5 != "0" ]] && echo "   已在data分区中删除$num_5个文件"
[[ $num_2 != "0" ]] && echo "   已在data分区中删除$num_2个文件夹"
[[ $num_8 != "0" ]] && echo "   已在data和sd卡中删除$num_8个APP残留文件夹"
[[ $ffile_num != "0" ]] && echo "   已在sd卡中删除$ffile_num个空文件"
[[ $fdir_num != "0" ]] && echo "   已在data和sd卡中删除$fdir_num个空文件夹"
echo "   已对data和sd卡中$adzw_ad_num个广告文件夹进行了加固"
echo -e "\033[32m \033[1m—————————————————————————————————————————\033[0m"
echo "   本次运行时间:$(( endtime-starttime ))秒，共清理${used_allsys}MB；其中"
echo "   data分区清理了`$awk_2 'BEGIN{print('$used_data' - '$used_sd')}'`MB(不含sd卡)"
echo "   sd卡清理了`$awk_2 'BEGIN{print('$used_sd' - '$used_sdandro')}'`MB(不含Android文件夹)"
echo "   Android文件夹清理了${used_sdandro}MB"
echo ""
}

catch_log(){
echo "*********** 清理列表如下 *******">>$sd/FileClear_zw_$nowtime.txt
echo "">>$sd/FileClear_zw_$nowtime.txt
$awk_2 'logtxt_1!=FILENAME{logtxt_1=FILENAME;print "****** "logtxt_1" ******"} {print "\t"$0}' $sd/adzw_[0-15].txt >>$sd/FileClear_zw_$nowtime.txt
echo "*********** 错误信息列表如下 ***********">>$sd/FileClear_zw_$nowtime.txt
echo "">>$sd/FileClear_zw_$nowtime.txt
$awk_2 'logtxt_2!=FILENAME{logtxt_2=FILENAME;print "****** "logtxt_2" ******"} {print "\t"$0}' $sd/adzw_[0-15]_err.txt >>$sd/FileClear_zw_$nowtime.txt
echo "*********** 广告文件夹加固列表如下 ***********">>$sd/FileClear_zw_$nowtime.txt
echo "">>$sd/FileClear_zw_$nowtime.txt
cat $sd/adzw_ad.txt >>$sd/FileClear_zw_$nowtime.txt
}

reboot_call_miuicleanmaster(){
if [[ `getprop ro.product.brand` = "Xiaomi" && -n `find /data/app -type d -iname "com.topjohnwu.magisk*"` ]]
then
  echo -e "\033[32m \033[1m  清理脚本运行完毕！！！15秒后自动重启手机 ！！\033[0m"
  echo -e "\033[32m \033[1m  重启后将调用MIUI官方清理APP，请手动清理  ！！\033[0m"
  echo ""
  [[ ! -d /data/adb/service.d ]] && mkdir -p /data/adb/service.d
  echo "#!/system/bin/sh">/data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh
  echo "# 这是FileClear for ZW(APP和垃圾清理模块)创建的一次性Shell脚本文件，旨在重启后通过面具APP启动MIUI Cleanmaster">>/data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh
  echo "sleep 20s">>/data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh
  echo "sh -c \"am start -a miui.intent.action.GARBAGE_CLEANUP -p com.miui.cleanmaster\"">>/data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh
  echo "rm -rf \$0">>/data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh
  chmod 777 /data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh
  sleep 15s
  rm -rf $sd/adzw* &>/dev/null
  reboot
else
  echo -e "\033[32m \033[1m  清理脚本运行完毕！！！15秒后自动重启手机 ！！\033[0m"
  echo ""
  sleep 15s
  rm -rf $sd/adzw* &>/dev/null
  reboot
fi
}

[[ $SELinux_on == "1" ]] && setenforce 1
[[ $module_31 == "1" ]] && alias sh=$sh_1
$find_2 $sd -iname "FileClear_zw_*.txt" \( -atime +3 -o -mtime +3 \) -delete &>/dev/null

if [[ $module_21 == "1" ]]
then
  yes_module
  catch_log
  wait
  reboot_call_miuicleanmaster
else
  no_module
  for input_key_1 in $*;do
    [[ $input_key_1 == "-l" || $input_key_1 == "l" || $input_key_1 == "log" ]] && catch_log
  done
  wait
  reboot_call_miuicleanmaster
fi