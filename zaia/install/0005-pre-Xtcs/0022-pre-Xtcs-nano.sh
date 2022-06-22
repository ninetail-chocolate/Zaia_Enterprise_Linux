#!/bin/bash
#name="Xtcs-xz"
#version"6.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.nano-editor.org/dist/v6/nano-6.2.tar.xz"
#}
#depend{
#	"pre-Xtcs-ncurses"
#	"pre-Xtcs-file"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/nano-6.2.tar.xz
cd nano-6.2


mkdir build
cd build
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -flto=full "			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -flto=full"			\
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
rm -rf nano-6.2
