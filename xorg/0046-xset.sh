#!/bin/bash
#name="xset"
#version="1.2.4"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/xset-1.2.4.tar.bz2"
#   }
#depend{
#	"libxshmfence"
#	"libpng"
#	"mesa"
#	"xbitmap"
#	"xcb-util"
#	"Linux-PAM"
#	"iceauth"
#	"lunit"
#	"mkfontscale"
#	"sessreg"
#	"setxkbmap"
#	"smproxy"
#	"x11pref"
#	"xauth"
#	"xbacklight"
#	"xcmsdb"
#	"xcursorgen"
#	"xdpyinfo"
#	"xdriinfo"
#	"xev"
#	"xgamma"
#	"xhost"
#	"xinput"
#	"xkbcomp"
#	"xkbevd"
#	"xkbutils"
#	"xkill"
#	"xlsatoms"
#	"xlsclients"
#	"xmessage"
#	"xmodmap"
#	"xpr"
#	"xprop"
#	"xrandr"
#	"xrdb"
#	"xrefresh"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/xset-1.2.4.tar.bz2
cd xset-1.2.4


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG

make


make install


cd ../
rm -rf xset-1.2.4
