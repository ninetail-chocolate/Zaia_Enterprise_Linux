#!/bin/bash
#name="pre-Xtcs-m4"
#version"1.4.19"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz"
#}
#depend{
#	"pre-Xtcs-musl"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/m4-1.4.19.tar.xz
cd m4-1.4.19

mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
STRIP=llvm-strip			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -flto=full --sysroot=$ZEL"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -flto=full --sysroot=$ZEL"			\
../configure						\
	--prefix=/usr					\
	--sysconfdir=/etc				\
	--mandir=/usr/share/man				\
	--infodir=/usr/share/info			\
	--localstatedir=/var				\
	--host=x86_64-zel-linux-musl			\
	--target=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--enable-shared					\
	--disable-static


make -j12


make DESTDIR=$ZEL install


cd ../../
rm -rf m4-1.4.19
