#!/bin/bash
#name="pre-Xtcs-file"
#version"5.41"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://astron.com/pub/file/file-5.41.tar.gz"
#}
#depend{
#	"pre-Xtcs-diffutils"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/file-5.41.tar.gz
cd file-5.41


mkdir build
cd build
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
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
	--disable-libseccomp		\
	--disable-xzlib			\
	--disable-zlib


make -j32


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

make DESTDIR=$ZEL install


cd ../../
rm -rf file-5.41
