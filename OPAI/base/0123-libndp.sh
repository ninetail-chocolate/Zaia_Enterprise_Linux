#!/bin/bash
#name="jansson"
#version"1.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://libndp.org/files/libndp-1.8.tar.gz"
#}
#depend{
#	"musl"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/libndp-1.8.tar.gz
cd libndp-1.8


mkdir build
cd build

../configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--localstatedir=/var		\
	--disable-static		\
	--enable-shared

make -j32


#make check -j32 | tee ../../logs/0122-jansson.log


make install


cd ../../
rm -rf libndp-1.8
