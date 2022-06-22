#!/bin/bash
#name="Xtcs-texinfo"
#version"6.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.gnu.org/gnu/texinfo/texinfo-6.8.tar.xz"
#}
#depend{
#	"pre-Xtcs-ncurses"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/texinfo-6.8.tar.xz
cd texinfo-6.8


mkdir build
cd build


CC=clang	\
CXX=clang++	\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
../configure					\
	--prefix=/usr				\
	--bindir=/usr/bin			\
	--sbindir=/usr/sbin			\
	--sysconfdir=/etc			\
	--mandir=/usr/share/man			\
	--infodir=/usr/share/info		\
	--localstatedir=/var			\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--enable-shared				\
	--disable-static


make -j32


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf texinfo-6.8
