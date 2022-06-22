#!/bin/bash
#name="pre-Xtcs-libtasn1"
#version"4.18.0"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/libtasn1/libtasn1-4.18.0.tar.gz"
#}
#depend{
#	"pre-Xtcs-musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/libtasn1-4.18.0.tar.gz
cd libtasn1-4.18.0


mkdir build
cd build
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -isystem="$ZEL" -flto=full "			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -isystem="$ZEL" -flto=full"			\
../configure				\
	--prefix=/usr			\
	--bindir=/usr/bin		\
	--sbindir=/usr/sbin		\
	--sysconfdir=/etc		\
	--mandir=/usr/share/man		\
	--infodir=/usr/share/info	\
	--localstatedir=/var		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--enable-shared			\
	--disable-static


make -j24


make DESTDIR=$ZEL install


cd ../../
rm -rf libtasn1-4.18.0
