#!/bin/bash
#name="pre-Xtcs-sed"
#version"4.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.gnu.org/gnu/sed/sed-4.8.tar.xz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/sed-4.8.tar.xz
cd sed-4.8


mkdir build
cd build
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl --sysroot=$ZEL -flto=full"		\
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



#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

make DESTDIR=$ZEL install


cd ../../
rm -rf sed-4.8
#CXX=$ZEL/tools/bin/clang++			\
#CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind""			\
