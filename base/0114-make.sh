#!/bin/bash
#name="make"
#version"4.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/make/make-4.3.tar.gz"
#}
#depend{
#	"pkg-config"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/make-4.3.tar.gz
cd make-4.3


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr


make -j32


make check -j32 | tee ../logs/0114-make.log


make install


cd ../
rm -rf make-4.3
