#!/bin/bash
#name="pre-Xtcs-binutils"
#version"2.38"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.38.tar.xz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/binutils-2.38.tar.xz
cd binutils-2.38


sed '6009s/$add_dir//' -i ltmain.sh
mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -D_LIBCPP_HAS_MUSL_LIBC --sysroot=$ZEL -flto=full"	\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -D_LIBCPP_HAS_MUSL_LIBC --sysroot=$ZEL -flto=full"			\
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
	--disable-static		\
	--enable-gold			\
	--enable-ld=default		\
	--enable-plugins		\
	--disable-werror		\
	--enable-64-bit-bfd


make tooldir=/usr -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST tooldir=/usr install

make DESTDIR=$ZEL tooldir=/usr install


cd ../../
rm -rf binutils-2.38
