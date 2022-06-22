#!/bin/bash
#name="Xtcs-bison"
#version"3.82"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/bison-3.8.2.tar.xz
cd bison-3.8.2


mkdir build
cd build


AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang	\
CXX=clang++	\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
../configure				\
	--prefix=/usr					\
	--bindir=/usr/bin				\
	--sbindir=/usr/sbin				\
	--sysconfdir=/etc				\
	--mandir=/usr/share/man				\
	--infodir=/usr/share/info			\
	--localstatedir=/var				\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--enable-shared					\
	--disable-static


make -j24


make install


cd ../../
rm -rf bison-3.8.2
