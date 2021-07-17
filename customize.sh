##########################################################################################
#
# Magisk模块安装脚本
#
##########################################################################################
# 如果您需要更多的自定义，并且希望自己做所有事情
# 请在custom.sh中标注SKIPUNZIP=1
# 以跳过提取操作并应用默认权限/上下文上下文步骤。
# 请注意，这样做后，您的custom.sh将负责自行安装所有内容。
SKIPUNZIP=1
# 如果您需要调用Magisk内部的busybox，请在custom.sh中标注ASH_STANDALONE=1
ASH_STANDALONE=0
####################################
# 安装
####################################
ui_print "

    #######################################
                FileClear for ZW
                    乐阿兰那
    #######################################
       一个基于MIUI的面具模块。旨在通过执行Shell脚
    本(Linux命令)清理微信、微博、QQ等APP缓存和垃圾
    文件，并屏蔽ad、.um、.uuid、MiPush、log等毒瘤
    和腾讯X5内核。与其他同类软件相比，具有不安装App、
    清理范围大、清理类型多、清理更彻底且自动化的优点
            **************************
    不是安装后立即生效，不是每次重启就清理垃圾！！！
    每隔N天，在特定时间点(比如凌晨5点)自动执行清理
    操作，并自动重起手机，动调用MIUI官方清理APP！！
    需要用户自己手动点击“清理选中垃圾”按钮！！！！
    日志文件保存于SD卡根目录“FileClear_zw_*.txt”。
            **************************
    这是免费模块，用爱发电的！遇到Bug，请自己排查、
    修复！如自愿协助作者修复Bug，请说清楚ROM情况，
    出问题的APP情况，问题怀疑对象等，不要只说现象！
            **************************
     这是我小米手机官方ROM自用脚本，不适配第三方！
     使用前务必认真根据自己实情修改脚本！！！！！
    #######################################

"

# 搜索删除非本模块的startclear.sh、startclear_service.sh文件
find /data/adb -type f -iname "startclear*.sh" -exec rm -f {} \; &>/dev/null
# 将 $ZIPFILE 提取到 $MODPATH
ui_print "-   开始解压模块文件"
unzip -qo "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2
[[ $? == "0" ]] && ui_print "-   开始编辑j11.sh文件"
sed -i '/^#!/ d' $MODPATH/system/app/j11.sh
sed -i '/^# / d' $MODPATH/system/app/j11.sh
sed -i '1i\#!\/system\/bin\/sh' $MODPATH/system/app/j11.sh
sed -i '3i\magisk_path=\$(magisk --path)\/.magisk' $MODPATH/system/app/j11.sh
sed -i '4i\export PATH=\/system\/bin:\$magisk_path\/busybox:$PATH' $MODPATH/system/app/j11.sh
# 对SD卡中旧日志文件进行处理
sd=/data/media/0;
nowtime=`date +"%m-%d_%T"`;
endtime=`date +%s`;
unset FileClear_logname;
find $sd -iname "FileClear_zw_*.txt" \( -atime +2 -o -mtime +2 \) -delete &>/dev/null
FileClear_logname=FileClear_zw_$nowtime.txt
sed -i "s/^FileClear_logname.*/FileClear_logname=$FileClear_logname/g" $MODPATH/service.sh && ui_print "-   修改service.sh中日志文件名称变量成功！"
sed -i "s/^Runj11time.*/Runj11time=$endtime/g" $MODPATH/service.sh && ui_print "-   修改service.sh中上次执行时间变量成功！"
# 将startclear.sh加入crontabs.txt
sed -i '/startclear.sh\"$/ d' $MODPATH/crontabs.txt
echo "0 */12 * * * su -c \"sh /data/adb/modules/zw_fileclear/startclear.sh\"" >>$MODPATH/crontabs.txt

# v3.8.9引入，修复因debug_log禁止写入而导致的Bug
# 读取既有模块的版本号
[[ $BOOTMODE ]] && version_old_code=`awk -F '=' '/^versionCode/ {print $2}' /data/adb/modules/zw_fileclear/module.prop` || version_old_code="0"
version_new_code=`awk -F '=' '/^versionCode/ {print $2}' $MODPATH/module.prop`
[[ $version_old_code -ne 0 && $version_old_code -le 20210325 ]] && { ui_print "-   开始修复早前版本的Bug";chmod 777 $MODPATH/uninstall.sh;. $MODPATH/uninstall.sh;}
#################################
# 权限设置
#################################
# 对于目录(包括文件):
# set_perm_recursive  <目录>    <所有者> <用户组> <目录权限> <文件权限>
# 默认权限请勿删除
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/system 0 0 0775 0755
set_perm_recursive $MODPATH/system/app 0 0 0775 0755
set_perm_recursive $MODPATH/system/bin 0 0 0775 0755
# 对于文件(不包括文件所在目录)
# set_perm  <文件名>            <所有者> <用户组> <文件权限>
chmod -R 775 $MODPATH/system
[[ ! -x $MODPATH/system/bin/xargs ]] && ui_print "-   system/bin文件夹授权失败"

#################################
# 删除多余文件
#################################
rm -rf $MODPATH/customize.sh $MODPATH/*.md 2>/dev/null