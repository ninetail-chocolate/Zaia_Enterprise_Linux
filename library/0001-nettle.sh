#!/bin/bash
#name="nettle"
#version="3.7.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/nettle/nettle-3.7.3.tar.gz"
#}
#depend{
#	"musl"
#	"gmp"
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


touch logs/0001-nettle.log
tar -xf src/nettle-3.7.3.tar.gz
cd nettle-3.7.3


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


make check -j32 | tee ../../logs/0001-nettle.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf nettle-3.7.3
