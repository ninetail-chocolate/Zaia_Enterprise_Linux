#!/bin/bash
#name="mpfr"
#version"4.1.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/mpfr/mpfr-4.1.0.tar.xz"
#}
#depend{
#	"gmp"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/mpfr-4.1.0.tar.xz
cd mpfr-4.1.0
touch ../logs/0133-mpfr.log


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
	--enable-thread-safe		\
	--disable-static		\
	--enable-shared

make 


make check -j32 | tee ../../logs/0133-mpfr.log


make install


cd ../../
rm -rf mpfr-4.1.0
