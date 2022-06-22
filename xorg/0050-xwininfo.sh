#!/bin/bash
#name="xwininfo"
#version="1.1.5"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/xwininfo-1.1.5.tar.bz2"
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
#	"xset"
#	"xsetroot"
#	"xvinfo"
#	"xwd"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/xwininfo-1.1.5.tar.bz2
cd xwininfo-1.1.5


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG


make


make install


cd ../
rm -rf xwininfo-1.1.5
