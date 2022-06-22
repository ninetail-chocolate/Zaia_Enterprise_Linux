#!/bin/bash
#name="libax25"
#version"1.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://www.linux-ax25.org/pub/libax25/libax25-0.0.12-rc5.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0102-libax25.log
tar -xf src/libax25-0.0.12-rc5.tar.gz
cd libax25-0.0.12-rc5


cat daemon.c | sed '1i #include <fcntl.h>' > daemon.c	
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--sysconfdir=/etc				\
	--localstatedir=/var				\
	--enable-shared					\
	--disable-static


make -j24


#make check  | tee ../../logs/0102-libax25.log


make install


cd ../../
rm -rf libax25-0.0.12-rc5
