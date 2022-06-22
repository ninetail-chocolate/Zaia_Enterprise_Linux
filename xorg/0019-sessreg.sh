#!/bin/bash
#name="sessreg"
#version="1.1.2"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/sessreg-1.1.2.tar.bz2"
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
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

tar -xf src/sessreg-1.1.2.tar.bz2
cd sessreg-1.1.2

./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG


make


make install


cd ../
rm -rf sessreg-1.1.2
