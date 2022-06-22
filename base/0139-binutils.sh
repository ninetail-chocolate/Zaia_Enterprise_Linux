#!/bin/bash
#name="binutils"
#version"2.38"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.38.tar.xz"
#}
#depend{
#	"gcc"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="gcc"


tar -xf src/binutils-2.38.tar.xz
cd binutils-2.38
touch ../logs/0136-binutils.log


mkdir build
cd build


../configure					\
	--prefix=/usr				\
	--enable-gold				\
	--enable-ld=default			\
	--enable-plugins			\
	--enable-shared				\
	--disable-werror			\
	--enable-64-bit-bfd			\
	--with-system-zlib			\
	--build=x86_64-zel-linux-musl		\
	--host=x86_64-zel-linux-musl


make tooldir=/usr -j32


#make check -j32 | tee ../../logs/0134-mpc.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make tooldir=/usr  install



cd ../../
rm -rf binutils-2.38
