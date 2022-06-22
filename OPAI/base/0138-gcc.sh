#!/bin/bash
#name="libgcc"
#version"1.2.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-11.2.0/gcc-11.2.0.tar.xz"
#}
#depend{
#	"mpc"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/gcc-11.2.0.tar.xz
cd gcc-11.2.0
touch ../logs/0133-mpc.log


sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64

mkdir build
cd build


../configure					\
	--prefix=/usr				\
	--disable-multilib			\
	--enable-languages=c,c++		\
	--with-system-zlib			\
	CC=clang CXX=clang++			\
	--disable-libssp			\
	--disable-libmpx			\
	--disable-libmudflap			\
	--disable-libsanitizer			\
	--disable-symver			\
	libat_cv_have_ifunc=no			\
	--build=x86_64-zel-linux-musl		\
	--host=x86_64-zel-linux-musl


make -j16


#make check -j32 | tee ../../logs/0134-mpc.log


mkdir DEST
make DESTDIR=$(pwd)/DEST install
cp -Rvf  DEST/usr/lib/libgcc_s.so* /usr/lib/
cp -Rvf  DEST/usr/lib/gcc/x86_64-zel-linux-musl/11.2.0/libgcc.a /usr/lib/


cd ../../
#rm -rf gcc-11.2.0
