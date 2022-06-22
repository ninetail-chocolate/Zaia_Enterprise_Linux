#!/bin/bash
#name="mpc"
#version"1.2.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/mpc/mpc-1.2.1.tar.gz"
#}
#depend{
#	"mpfr"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/mpc-1.2.1.tar.gz
cd mpc-1.2.1
touch ../logs/0133-mpc.log


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

make 


make check -j32 | tee ../../logs/0134-mpc.log


make install


cd ../../
rm -rf mpc-1.2.1
