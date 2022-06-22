#!/bin/bash
#name="libwebp"
#version="1.2.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.2.tar.gz"
#}
#depend{
#	"libjpeg-turbo"
#	"libpng"
#	"libtiff"
#	"freeglut"
#	"giflib"
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


#touch logs/0008-yasm.log
tar -xf src/libwebp-1.2.2.tar.gz
cd libwebp-1.2.2


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--enable-libwebpmux			\
	--enable-libwebpdemux			\
	--enable-libwebpdecoder			\
	--enable-libwebpextras			\
	--enable-swap-16bit-csp

make -j32


#make check -j32 | tee ../../logs/0008-yasm.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libwebp-1.2.2
