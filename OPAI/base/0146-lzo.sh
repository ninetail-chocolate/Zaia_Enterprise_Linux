#!/bin/bash
#name="lzo"
#version"2.10"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0144-lzo.log
tar -xf src/lzo-2.10.tar.gz
cd lzo-2.10


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static


make -j32


make -j32 check | tee ../../logs/0144-lzo.log
make  test >> ../../logs/0144-lzo.log


make install -j24


cd ../../
rm -rf lzo-2.10
