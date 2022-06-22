#!/bin/bash
#name="luit-1.1.1.tar.bz2"
#version="1.1.1"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/luit-1.1.1.tar.bz2"
#   }
#depend{
#	"libxshmfence"
#	"libpng"
#	"mesa"
#	"xbitmap"
#	"xcb-util"
#	"Linux-PAM"
#	"iceauth"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/luit-1.1.1.tar.bz2
cd luit-1.1.1


sed -i -e "/D_XOPEN/s/5/6/" configure

./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG


make


make install


cd ../
rm -rf luit-1.1.1
