#!/bin/bash
#name="fdk-aac"
#version="2.0.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.sourceforge.net/opencore-amr/fdk-aac-2.0.2.tar.gz"
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


source /etc/profile

#touch logs/0033-libsamplerate.log
tar -xf src/fdk-aac-2.0.2.tar.gz
cd fdk-aac-2.0.2

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


#make check -j32 | tee ../../logs/0033-libsamplerate.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf fdk-aac-2.0.2
