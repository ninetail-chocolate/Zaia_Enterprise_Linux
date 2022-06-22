#!/bin/bash
#name="jansson"
#version"2.13.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://digip.org/jansson/releases/jansson-2.13.1.tar.gz"
#}
#depend{
#	"openssl"
#	"zlib"
#	"pcre"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/jansson-2.13.1.tar.gz
cd jansson-2.13.1


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
	--disable-static		\
	--enable-shared

make -j32


make check -j32 | tee ../../logs/0122-jansson.log


make install


cd ../../
rm -rf jansson-2.13.1
