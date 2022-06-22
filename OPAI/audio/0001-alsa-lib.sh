#!/bin/bash
#name="alsa-lib"
#version="1.2.6"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.6.tar.bz2"
#}
#depend{
#	"networkmanager"
#	"libpng"
#	"xserver"
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


touch logs/0001-alsa-lib.log
tar -xf src/alsa-lib-1.2.6.tar.bz2
cd alsa-lib-1.2.6


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static

make -j32


make check -j32 | tee ../../logs/0001-alsa-lib.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf alsa-lib-1.2.6
