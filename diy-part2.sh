#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

#=================================================
# Clone OpenClash 项目
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull origin master
git branch --set-upstream-to=origin/master master
cd ..

# Clone source.openwrt.melmac.net.git
git clone -b master https://github.com/stangri/source.openwrt.melmac.net source.openwrt.melmac.net
cp -r source.openwrt.melmac.net/pbr package/pbr
cp -r source.openwrt.melmac.net/luci-app-pbr package/luci/applications/luci-app-pbr

# 编译 po2lmo
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd

#=================================================
# Clone Argon 主题
git clone -b master https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
