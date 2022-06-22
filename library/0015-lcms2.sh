#!/bin/bash
#name="lcms2"
#version="2.13.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/lcms/files/lcms/2.13/lcms2-2.13.1.tar.gz"
#}
#depend{
#	"libjpeg-turbo"
#	"libtiff"
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


touch logs/0015-lcms2.log
tar -xf src/lcms2-2.13.1.tar.gz
cd lcms2-2.13.1


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


make check -j32 | tee ../../logs/0015-lcms2.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf lcms2-2.13.1
