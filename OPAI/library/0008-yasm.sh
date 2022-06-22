#!/bin/bash
#name="yasm"
#version="1.3.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz"
#}
#depend{
#	"musl"
#}
#groupdepend{
#		""
#	}
#replace{
#	""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0008-yasm.log
tar -xf src/yasm-1.3.0.tar.gz
cd yasm-1.3.0


sed -i 's#) ytasm.*#)#' Makefile.in
mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure						\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static

make -j32


make check -j32 | tee ../../logs/0008-yasm.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf yasm-1.3.0
