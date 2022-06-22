#!/bin/bash
#name="mkfontscale"
#version="1.2.1"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/mkfontscale-1.2.1.tar.bz2"
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
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/mkfontscale-1.2.1.tar.bz2
cd mkfontscale-1.2.1


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG


make


make install


cd ../
rm -rf mkfontscale-1.2.1
