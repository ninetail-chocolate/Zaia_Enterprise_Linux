#!/bin/bash
#name="libtheora"
#version="1.1.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.osuosl.org/pub/xiph/releases/theora/libtheora-1.1.1.tar.xz"
#}
#depend{
#	"libogg"
#	"libvorbis"
#	"libpng"
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


source /etc/profile

touch logs/0037-libtheora.log
tar -xf src/libtheora-1.1.1.tar.xz
cd libtheora-1.1.1


sed -i 's/png_\(sizeof\)/\1/g' examples/png2theora.c 
mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static

make -j32


make check -j32 | tee ../../logs/0037-libtheora.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libtheora-1.1.1
