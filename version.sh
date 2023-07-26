# 此文件用于配置编译时使用的openwrt源码版本以及插件版本，若文件或配置不存在，则默认使用最新的代码编译
# 问：为什么要有这个版本号机制而不是默认就使用最新版本编译
# 答：由于OP和插件源码更新非常频繁，部分更新可能会导致编译失败，所以需要有一个Release版本机制，记录百分百能够编出来的版本
# 目前本文件由Workflow定时自动更新
OPENWRT_VER=R23.07.27
OPENWRT_COMMIT_ID=37eaf33035f2c01f4f0d97fbcce25f75ffebd697
OPENWRT_PACKAGES_COMMIT_ID=61b31b80d2d7e89730ba7773dff774b30d6a814f
PASSWALL_PACKAGE_COMMIT_ID=f4eb43bf488e1e26f3c4a41ffbc5e642931a2204
SMALL_PACKAGE_COMMIT_ID=a2d5ef59f5cdf97d38d410ce3a527c8c5331c132
