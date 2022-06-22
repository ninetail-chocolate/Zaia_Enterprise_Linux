#!/bin/bash
#name="eudev"
#version"2.4.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/eudev-project/eudev/releases/download/v3.2.11/eudev-3.2.11.tar.gz"
#}
#depend{
#	"musl"
#	"ncurses"
#	"libintl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0105-procps-ng.log
tar -xf src/eudev-3.2.11.tar.gz
cd eudev-3.2.11


#patch -Np1 -i ../src/musl-procps.patch
#pwd
#cat w.c | sed '25i #include <utmp.h>' > w.c	
#cat proc/escape.c  | sed '19i #include <langinfo.h>' > proc/escape.c	
#sed -i 's/libtoolize/libtoolize-GNU/g' autogen.sh


#./autogen.sh
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"	\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--libdir=/usr/lib			\
	--enable-shared				\
	--disable-static			\
	--enable-introspection			\
	--enable-kmod

make -j24


#make check  | tee ../../logs/0105-procps-ng.log


make install


cd ../../
rm -rf eudev-3.2.11
