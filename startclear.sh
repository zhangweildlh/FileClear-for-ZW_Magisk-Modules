#!/system/bin/sh
# 将此脚本放到/data/adb/modules/*

# 无响应日志
clear_dir() {
rm -rf /data/anr/* &>/dev/null
# 系统暂挂备份文件
rm -rf /data/backup/pending/* &>/dev/null
# 系统(应用)崩溃日志
rm -rf /data/crashdata/* &>/dev/null
rm -rf /data/tombstones/* &>/dev/null
rm -rf /dev/fscklogs/* &>/dev/null
rm -rf /idd/crashdata/* &>/dev/null
rm -rf /data/dalvik-cache/* &>/dev/null
# 系统跟踪记录
rm -rf /data/local/* &>/dev/null
# DropBox的日志
rm -rf /data/system/dropbox/* &>/dev/null
# 安装缓存
rm -rf /data/system/package_cache/* &>/dev/null
# 进程统计
rm -rf /data/system/procstats/* &>/dev/null
# App启动统计信息
rm -rf /data/system/usagestats/* &>/dev/null
# 同步管理日志
rm -rf /data/system/syncmanager-log/* &>/dev/null
rm -rf /data/system_ce/0/recent_images/* &>/dev/null
# "最近任务"缓存
rm -rf /data/system_ce/0/recent_tasks/* &>/dev/null
rm -rf /data/system_ce/0/snapshots/* &>/dev/null
rm -rf /sys/kernel/debug/* &>/dev/null
rm -rf /proc/sys/debug/* &>/dev/null
# 电池用量统计
rm -rf /data/system/batterystats.bin &>/dev/null
rm -rf /data/system/batterystats-checkin.bin &>/dev/null
# App垃圾
rm -rf /data/data/com.sohu.inputmethod.sogou/databases/sogou_push &>/dev/null
rm -rf /data/media/0/Android/data/com.sohu.inputmethod.sogou/files/flx &>/dev/null
rm -rf /data/data/com.ss.android.ugc.aweme/shared_prefs/ACCS_BINDumeng:*.xml &>/dev/null
rm -rf /data/data/com.ss.android.ugc.aweme/shared_prefs/ACCS_SDK_CHANNEL.xml &>/dev/null
rm -rf /data/data/com.ss.android.ugc.aweme/shared_prefs/ACCS_SDK.xml &>/dev/null
rm -rf /data/data/com.ss.android.ugc.aweme/shared_prefs/umeng_general_config.xml &>/dev/null
rm -rf /data/data/com.ss.android.ugc.aweme/shared_prefs/umeng_message_state.xml &>/dev/null
find /data -type d \( -iname "*_ad" -o\
 -iname "*_cache" -o\
 -iname "*_cache_*" -o\
 -iname "*splash" -o\
 -iname ".*cache" -o\
 -iname ".umeng" -o\
 -iname "ad" -o\
 -iname "adcache" -o\
 -iname "ads" -o\
 -iname "cache" -o\
 -iname "code_cache" -o\
 -iname "debug" -o\
 -iname "debug_log" -o\
 -iname "dump" -o\
 -iname "MiPushLog" -o\
 -iname "package_cache" -o\
 -iname "spla*ad" -o\
 -iname "spla*cache" -o\
 -iname "xlog" \) -print0 | sed -e '/.auth_cache/ d' -e '/yttrium_code_cache/ d' -e '/\/lib\// d' -e '/\/lib64\// d' -e '/.so/ d' | $(magisk --path)/.magisk/busybox/xargs  -0 -P 80 -n 20 rm -rf &>/dev/null
}

# 清理腾讯系垃圾文件夹
clear_tencent_dir() {
sd_tencent=([Tt]encent/.emotionsm\
 [Tt]encent/.font_info\
 [Tt]encent/.gift\
 [Tt]encent/.hiboom_font\
 [Tt]encent/.trooprm/enter_effects\
 [Tt]encent/.pendant\
 [Tt]encent/.profilecard\
 [Tt]encent/.sticker_recommended_pics\
 [Tt]encent/.vaspoke\
 [Tt]encent/.vipicon\
 [Tt]encent/beacon\
 [Tt]encent/blob\
 [Tt]encent/com\
 [Tt]encent/DoutuRes\
 [Tt]encent/funcall\
 [Tt]encent/mini\
 [Tt]encent/MicroMsg/[0-9a-z]*/bizimg\
 [Tt]encent/MicroMsg/[0-9a-z]*/favoffline\
 [Tt]encent/MicroMsg/[0-9a-z]*/favorite\
 [Tt]encent/MicroMsg/[0-9a-z]*/image\
 [Tt]encent/MicroMsg/[0-9a-z]*/image2\
 [Tt]encent/MicroMsg/[0-9a-z]*/oneday\
 [Tt]encent/MicroMsg/[0-9a-z]*/recbiz\
 [Tt]encent/MicroMsg/[0-9a-z]*/video\
 [Tt]encent/MicroMsg/[0-9a-z]*/video2\
 [Tt]encent/MicroMsg/bigfile\
 [Tt]encent/MicroMsg/CheckResUpdate\
 [Tt]encent/MicroMsg/sns_ad_landingpages\
 [Tt]encent/MicroMsg/vusericon\
 [Tt]encent/MicroMsg/wallet_images\
 [Tt]encent/MicroMsg/wxafiles/[a-z][a-z][0-9a-z]*\
 [Tt]encent/mini\
 [Tt]encent/MobileQQ\
 [Tt]encent/MobileQQ/.apollo/rsc_jsonconfig/100_1_all_room3d\
 [Tt]encent/MobileQQ/.corlornick\
 [Tt]encent/MobileQQ/.emotionsm\
 [Tt]encent/MobileQQ/.font_effect\
 [Tt]encent/MobileQQ/.font_info\
 [Tt]encent/MobileQQ/.fontbubble\
 [Tt]encent/MobileQQ/.gift\
 [Tt]encent/MobileQQ/.hiboom_font\
 [Tt]encent/MobileQQ/.now_video\
 [Tt]encent/MobileQQ/.pendant\
 [Tt]encent/MobileQQ/.readInjoy\
 [Tt]encent/MobileQQ/.signaturetemplate\
 [Tt]encent/MobileQQ/.troop\
 [Tt]encent/MobileQQ/.vipicon\
 [Tt]encent/MobileQQ/aio_long_shot\
 [Tt]encent/MobileQQ/appicon\
 [Tt]encent/MobileQQ/ar_feature\
 [Tt]encent/MobileQQ/ar_model\
 [Tt]encent/MobileQQ/artfilter\
 [Tt]encent/MobileQQ/avatarpendantdefaulthead\
 [Tt]encent/MobileQQ/avatarpendanticons\
 [Tt]encent/MobileQQ/bless\
 [Tt]encent/MobileQQ/bubble_info\
 [Tt]encent/MobileQQ/capture_ptv_template\
 [Tt]encent/MobileQQ/capture_qsvf\
 [Tt]encent/MobileQQ/card\
 [Tt]encent/MobileQQ/chatpic\
 [Tt]encent/MobileQQ/doodle_template\
 [Tt]encent/MobileQQ/doutures\
 [Tt]encent/MobileQQ/dov_doodle_music\
 [Tt]encent/MobileQQ/dov_doodle_sticker\
 [Tt]encent/MobileQQ/dov_doodle_template\
 [Tt]encent/MobileQQ/dov_ptv_template_dov\
 [Tt]encent/MobileQQ/dynamic_text\
 [Tt]encent/MobileQQ/flashchat\
 [Tt]encent/MobileQQ/foward_urldrawable\
 [Tt]encent/MobileQQ/funcall\
 [Tt]encent/MobileQQ/head/_dynamic\
 [Tt]encent/MobileQQ/head/_hd\
 [Tt]encent/MobileQQ/head/_SSOhd\
 [Tt]encent/MobileQQ/head/_st\
 [Tt]encent/MobileQQ/head/_stranger\
 [Tt]encent/MobileQQ/hotimage\
 [Tt]encent/MobileQQ/hotpic\
 [Tt]encent/MobileQQ/iar\
 [Tt]encent/MobileQQ/information_paster\
 [Tt]encent/MobileQQ/keyword_emotion\
 [Tt]encent/MobileQQ/listentogether\
 [Tt]encent/MobileQQ/lottie\
 [Tt]encent/MobileQQ/ocr\
 [Tt]encent/MobileQQ/pddata\
 [Tt]encent/MobileQQ/photo\
 [Tt]encent/MobileQQ/play_show_apng\
 [Tt]encent/MobileQQ/portrait\
 [Tt]encent/MobileQQ/ppt\
 [Tt]encent/MobileQQ/pubaccount\
 [Tt]encent/MobileQQ/qav\
 [Tt]encent/MobileQQ/qbiz\
 [Tt]encent/MobileQQ/qbosssplahad\
 [Tt]encent/MobileQQ/QQ_Images\
 [Tt]encent/MobileQQ/QQEditPic\
 [Tt]encent/MobileQQ/qqcomic\
 [Tt]encent/MobileQQ/qqconnect\
 [Tt]encent/MobileQQ/qqmusic\
 [Tt]encent/MobileQQ/qqstory\
 [Tt]encent/MobileQQ/rijmmkv\
 [Tt]encent/MobileQQ/scribble\
 [Tt]encent/MobileQQ/shortvideo\
 [Tt]encent/MobileQQ/status_ic\
 [Tt]encent/MobileQQ/sticker_recommended_pics\
 [Tt]encent/MobileQQ/subscribe_draft\
 [Tt]encent/MobileQQ/subscribe_draft_simple\
 [Tt]encent/MobileQQ/sv_config_resource\
 [Tt]encent/MobileQQ/[Tt]encent/Mobileqq/webso\
 [Tt]encent/MobileQQ/thumb\
 [Tt]encent/MobileQQ/thumb2\
 [Tt]encent/MobileQQ/vas\
 [Tt]encent/MobileQQ/video_story\
 [Tt]encent/MobileQQ/viola\
 [Tt]encent/MobileQQ/voicechange\
 [Tt]encent/MobileQQ/webviewcheck\
 [Tt]encent/MobileQQ/zhitu\
 [Tt]encent/mta\
 [Tt]encent/newpoke\
 [Tt]encent/poke\
 [Tt]encent/QQ_cameraemo\
 [Tt]encent/QQ_collection/pic\
 [Tt]encent/QQ_favorite\
 [Tt]encent/QQ_Images/qqeditpic\
 [Tt]encent/QQfile_recv\
 [Tt]encent/qqhomework_attach\
 [Tt]encent/qqhomework_recv\
 [Tt]encent/QQLite/.emotionsm\
 [Tt]encent/QQLite/ArkApp\
 [Tt]encent/QQLite/data\
 [Tt]encent/QQLite/early\
 [Tt]encent/qzone\
 [Tt]encent/readerzone\
 [Tt]encent/TMAssistantSDK\
 [Tt]encent/vs\
 [Tt]encent/WeiXin/[0-9a-z]*/image2\
 [Tt]encent/WeiXin/bigfile\
 [Tt]encent/WeiXin/sns_ad_landingpages\
 [Tt]encent/wtlogin\
 [Tt]encentmapsdk)
sd_data_tencent=(com.tencent.mm/beacon\
 com.tencent.mm/blob\
 com.tencent.mm/cache\
 com.tencent.mm/com\
 com.tencent.mm/files/data\
 com.tencent.mm/files\
 com.tencent.mm/MicroMsg/.tmp\
 com.tencent.mm/MicroMsg/[0-9a-z]*/attachment\
 com.tencent.mm/MicroMsg/[0-9a-z]*/bizimg\
 com.tencent.mm/MicroMsg/[0-9a-z]*/emoji\
 com.tencent.mm/MicroMsg/[0-9a-z]*/favoffline\
 com.tencent.mm/MicroMsg/[0-9a-z]*/favorite\
 com.tencent.mm/MicroMsg/[0-9a-z]*/finder\
 com.tencent.mm/MicroMsg/[0-9a-z]*/image\
 com.tencent.mm/MicroMsg/[0-9a-z]*/image2\
 com.tencent.mm/MicroMsg/[0-9a-z]*/mailapp\
 com.tencent.mm/MicroMsg/[0-9a-z]*/music/cover/mv_default_video
 com.tencent.mm/MicroMsg/[0-9a-z]*/openim\
 com.tencent.mm/MicroMsg/[0-9a-z]*/recbiz\
 com.tencent.mm/MicroMsg/[0-9a-z]*/record\
 com.tencent.mm/MicroMsg/[0-9a-z]*/video\
 com.tencent.mm/MicroMsg/[0-9a-z]*/video2\
 com.tencent.mm/MicroMsg/bigfile\
 com.tencent.mm/MicroMsg/browser\
 com.tencent.mm/MicroMsg/CDNTemp\
 com.tencent.mm/MicroMsg/CheckResUpdate\
 com.tencent.mm/MicroMsg/crash\
 com.tencent.mm/MicroMsg/facedir\
 com.tencent.mm/MicroMsg/fts\
 com.tencent.mm/MicroMsg/Game\
 com.tencent.mm/MicroMsg/mapsdk/[Tt]encentmapsdk/com.tencent.mm/data/v[0-9]/render/events/icons/\
 com.tencent.mm/MicroMsg/recovery/version.info\
 com.tencent.mm/MicroMsg/sns_ad_landingpages\
 com.tencent.mm/MicroMsg/vusericon\
 com.tencent.mm/MicroMsg/wallet\
 com.tencent.mm/MicroMsg/wallet_images\
 com.tencent.mm/MicroMsg/wxacache\
 com.tencent.mm/MicroMsg/wxafiles\
 com.tencent.mm/MicroMsg/wxanewfiles\
 com.tencent.mm/MobileQQ/doutures\
 com.tencent.mm/MobileQQ/subscribe_draft\
 com.tencent.mm/MobileQQ/subscribe_draft_simple\
 com.tencent.mm/mta\
 com.tencent.mm/QQfile_recv\
 com.tencent.mm/vs)
data_tencent=(com.tencent.mm/files/kvcomm/monitordata*\
 com.tencent.mm/files/liteapp\
 com.tencent.mm/files/public/box\
 com.tencent.mm/files/public/CheckResUpdate\
 com.tencent.mm/files/public/cityService\
 com.tencent.mm/files/public/emoji/res\
 com.tencent.mm/files/public/fts\
 com.tencent.mm/files/public/live\
 com.tencent.mm/files/public/ocr\
 com.tencent.mm/files/public/tagsearch\
 com.tencent.mm/files/public/websearch\
 com.tencent.mm/files/wx[0-9]*/*.apk\
 com.tencent.mm/MicroMsg/[0-9a-z]*/avatar\
 com.tencent.mm/MicroMsg/[0-9a-z]*/image2\
 com.tencent.qqmusic/app_adnet)
for temp_sd_tencent in ${sd_tencent[*]};do
  rm -rf /data/media/0/$temp_sd_tencent &>/dev/null
done
for temp_sd_data_tencent in ${sd_data_tencent[*]};do
  rm -rf /data/media/0/Android/data/$temp_sd_data_tencent &>/dev/null
done
for temp_data_tencent in ${data_tencent[*]};do
  rm -rf /data/data/$temp_data_tencent &>/dev/null
done
}

# 清理垃圾文件
clear_file() {
find /data -type f \( -iname "*.bak" -o\
 -iname "*.temp" -o\
 -iname "*.tlog" -o\
 -iname "*.tmfs" -o\
 -iname "*.tmp" -o\
 -iname "*_log" -o\
 -iname "*_log*.txt" -o\
 -iname "*error" -o\
 -iname "*log" -o\
 -iname "*log.lock" -o\
 -iname "*log.txt" -o\
 -iname "*log[0-9].txt" -o\
 -iname "*logs" -o\
 -iname "*logs*.txt" -o\
 -iname "awp_core.apk" -o\
 -iname "log_*.txt" -o\
 -iname "logs_*.txt" -o\
 -iname "Thumbs.db" -o\
 -iname "x5.backup*" \) -exec rm -rf {} \; &>/dev/null
}

# 删除毒瘤APP
uninstall_app() {
unin_app=(com.miui.analytics)
for temp_unin_app in ${unin_app[*]};do
  if [[ -n $(/system/bin/pm list packages | grep $temp_unin_app) ]];then
    /system/bin/pm uninstall $temp_unin_app &>/dev/null
  fi
done
}

# 回收文件系统未使用的空间
recycling_space() {
fstrim_2="$(magisk --path)/.magisk/busybox/fstrim"
$fstrim_2 -v / &>/dev/null
for fstrim_temp in $(/system/bin/ls -l / |grep ^d|awk '{print $8}')
do
  $fstrim_2 -v "/""$fstrim_temp" &>/dev/null
done
sm fstrim 2>/dev/null
sync
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
sync
}

# 安装crontabs服务(文件)
install_crontabs() {
touch /var/spool/cron/crontabs/root
cat>/var/spool/cron/crontabs/root<<eof
#!/system/bin/sh
SHELL=/system/bin/sh
MAILTO=root
HOME=/
magisk_path=\$(magisk --path)/.magisk/busybox
PATH=/system/bin:\$magisk_path:\$PATH

# 定时执行任务，请自行修改脚本执行时间，重启后生效
# run-parts
0 */12 * * * su -c "sh $temp_startclear_path"
eof
}


sleep 10s
# 挂载分区为可写
magisk_path=$(magisk --path)/.magisk
mount|grep "ro,"|grep -v "$magisk_path/"|awk -F'[ ,]' '{print $1,$3}'|while read a b
do
mount -o rw,remount $a $b &>/dev/null
done
# 检查并启动crontabs服务
temp_startclear_path=$(find /data/adb/modules -type f -iname startclear.sh 2>/dev/null)
test ! -d /var/spool/cron/crontabs && (mkdir -p /var/spool/cron/crontabs;install_crontabs)
test ! -f /var/spool/cron/crontabs/root && install_crontabs
temp_crontabs_startclear=$(grep -i "startclear.sh\"$" /var/spool/cron/crontabs/root)
test -z "$temp_crontabs_startclear" && echo "0 */12 * * * su -c \"sh $temp_startclear_path\"" >>/var/spool/cron/crontabs/root
chmod -R 0777 /var/spool/cron/crontabs/root
crond_2="$(magisk --path)/.magisk/busybox/crond"
test -z $(pgrep crond) && $crond_2 start
test -f /data/adb/service.d/call_miuicleanmaster-for-zw_fileclear.sh && exit 1

if [[ $1 == "-d" || $1 == "d" ]];then
  clear_dir
elif [[ $1 == "-td" || $1 == "td" ]];then
  clear_tencent_dir
elif [[ $1 == "-f" || $1 == "f" ]];then
  clear_file
elif [[ $1 == "-u" || $1 == "u" ]];then
  uninstall_app
elif [[ $1 == "-c" || $1 == "c" ]];then
  clear_dir &
  clear_tencent_dir &
  clear_file &
  wait
  recycling_space
elif [[ $1 == "-h" || $1 == "--help" ]];then
  echo -e "  参数-f或f，清理垃圾文件；\n  参数-c或c，清理垃圾文件(夹)；\n  参数-d或d，只清理垃圾文件夹；\n    参数-td或td，只清理腾讯系垃圾文件夹；\n  参数-u或u，删除毒瘤APP；\n  无参数，执行整个脚本所有功能！"
elif [[ -z $1 ]];then
  clear_dir &
  clear_tencent_dir &
  clear_file &
  uninstall_app
  wait
  recycling_space
fi
