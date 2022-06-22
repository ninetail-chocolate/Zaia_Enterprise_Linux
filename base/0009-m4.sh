#!/bin/bash
#name="m4"
#version"1.4.19"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/m4/m4-1.4.19.tar.xz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0009-m4.log
tar -xf src/m4-1.4.19.tar.xz
cd m4-1.4.19


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr


time make -j24


time make check -j24 | tee ../../logs/0009-m4.log


time make install


cd ../../
rm -rf m4-1.4.19
