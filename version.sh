# 此文件用于配置编译时使用的openwrt源码版本以及插件版本，若文件或配置不存在，则默认使用最新的代码编译
# 问：为什么要有这个版本号机制而不是默认就使用最新版本编译
# 答：由于OP和插件源码更新非常频繁，部分更新可能会导致编译失败，所以需要有一个Release版本机制，记录百分百能够编出来的版本
# 目前本文件由Workflow定时自动更新
OPENWRT_VER=R23.07.01
OPENWRT_COMMIT_ID=a14bb92a80ec72a7e87cf73918ebc770ed311695
OPENWRT_PACKAGES_COMMIT_ID=f61c185f09fcf43b5dd867136675f1e700626fb7
PASSWALL_PACKAGE_COMMIT_ID=bd5b2622bc305707df6b61e216ead0e0b1b39158
SMALL_PACKAGE_COMMIT_ID=70d016566ff203c0a2634574eecab0f1d244847f
