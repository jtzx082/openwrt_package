#!/bin/bash
# 此脚本为作者个人使用，用于在个人服务器上定时编译，若有类似需求可参考编写
# 编译定时任务命令：crontab –e（需要安装定时任务组件: apt-get install cron）
# 定时任务配置如下：每天凌晨3点30分执行编译
# 30 3 * * * bash /openwrt_package/scripts/schedule_package.sh
source /etc/profile
set -e
BASE_DIR=$(cd $(dirname $0);cd ..; pwd)
NOW_DATE=$(TZ=':Asia/Shanghai' date '+%Y%m%d')
# 固件输出根目录
FIRMWARE_DIR=/data/webroot/firmware
# 固件输出具体目录（按照日期建立目录）
FIRMWARE_OUTPUT_DIR=$FIRMWARE_DIR/$NOW_DATE
# 固件有效期
FIRMWARE_EXPIRED_DAY=7
# 编译时使用的容器名
NAME=schedule_package_$NOW_DATE
# 推送编译通知到手机上，可以自己到pushplus申请token配到环境中
START_CONTENT='http://www.pushplus.plus/send?token='${PUSH_TOKEN}'&title=%E5%BC%80%E5%A7%8B%E7%BC%96%E8%AF%91openwrt%E5%9B%BA%E4%BB%B6&content=%E6%9C%AC%E6%AC%A1%E7%BC%96%E8%AF%91%E5%AE%B9%E5%99%A8%E5%90%8D%EF%BC%9A'$NAME
curl $START_CONTENT
cd $BASE_DIR
git pull
rm -rf $BASE_DIR/openwrt_build_tmp
./run_build_use_docker.sh -c common -d vplus -r -n $NAME
# 由于前面步骤已完成底包编译，这里仅只需打包章鱼星球固件即可
./run_build_use_docker.sh -c common -d s912 -p -n $NAME
# 根据当前日期重新建立固件目录
[ -d "$FIRMWARE_OUTPUT_DIR" ] && rm -rf $FIRMWARE_OUTPUT_DIR 
# 清理过期的固件
find $FIRMWARE_DIR -mtime +$FIRMWARE_EXPIRED_DAY  -exec rm {} \;
mkdir -p $FIRMWARE_OUTPUT_DIR && mv $BASE_DIR/openwrt_build_tmp/artifact/* $FIRMWARE_OUTPUT_DIR
[ `docker ps -a | grep $NAME | wc -l` -eq 0 ] || docker rm -f $NAME
echo '固件定时编译完毕：'$FIRMWARE_OUTPUT_DIR
END_CONTENT='http://www.pushplus.plus/send?token='${PUSH_TOKEN}'&title=%E5%9B%BA%E4%BB%B6%E7%BC%96%E8%AF%91%E5%AE%8C%E6%88%90&content=%E5%9B%BA%E4%BB%B6%E6%89%80%E5%9C%A8%E7%9B%AE%E5%BD%95%EF%BC%9Ahttps%3A%2F%2Ffile.4yuan.top%2Ffiles%2F'$NOW_DATE
curl $END_CONTENT