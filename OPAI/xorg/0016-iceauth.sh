#!/bin/bash
#name="iceauth"
#version="1.0.8"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/iceauth-1.0.8.tar.bz2"
#   }
#depend{
#	"libxshmfence"
#	"libpng"
#	"mesa"
#	"xbitmap"
#	"xcb-util"
#	"Linux-PAM"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/iceauth-1.0.8.tar.bz2
cd iceauth-1.0.8


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG
make


make install


cd ../
rm -rf iceauth-1.0.8
