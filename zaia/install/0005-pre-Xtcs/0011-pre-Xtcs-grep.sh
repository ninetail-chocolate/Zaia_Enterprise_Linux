#!/bin/bash
#name="pre-Xtcs-grep"
#version"3.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.gnu.org/gnu/grep/grep-3.7.tar.xz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/grep-3.7.tar.xz
cd grep-3.7


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
	--build=x86_64-zel-linux-musl


make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

make DESTDIR=$ZEL install


cd ../../
rm -rf grep-3.7
