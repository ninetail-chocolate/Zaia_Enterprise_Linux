#!/bin/bash
#name="opus"
#version="1.3.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz"
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

touch logs/0027-opus.log
tar -xf src/opus-1.3.1.tar.gz
cd opus-1.3.1


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


make check -j32 | tee ../../logs/0027-opus.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf opus-1.3.1
