#!/bin/bash
#name="lcms2"
#version="2.0.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/libmng/files/libmng-devel/2.0.3/libmng-2.0.3.tar.xz"
#}
#depend{
#	"libjpeg-turbo"
#	"lcms2"
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


#touch logs/0015-lcms2.log
tar -xf src/libmng-2.0.3.tar.xz
cd libmng-2.0.3


make distclean
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


#make check -j32 | tee ../../logs/0015-lcms2.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libmng-2.0.3
