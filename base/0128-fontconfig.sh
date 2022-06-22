#!/bin/bash
#name="fontconfig"
#version"2.13.96"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.96.tar.gz"
#}
#depend{
#	"freetype"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/fontconfig-2.13.96.tar.gz
cd fontconfig-2.13.96


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--localstatedir=/var		\
	--disable-static		\
	--enable-shared

make 


make check -j32 | tee ../logs/0128-fontconfig.log


make install


cd ../
rm -rf fontconfig-2.13.96
