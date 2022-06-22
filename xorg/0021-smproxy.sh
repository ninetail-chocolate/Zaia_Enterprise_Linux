#!/bin/bash
#name="smproxy"
#version="1.0.6"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/smproxy-1.0.6.tar.bz2"
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
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/smproxy-1.0.6.tar.bz2
cd smproxy-1.0.6


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG

make


make install


cd ../
rm -rf smproxy-1.0.6
