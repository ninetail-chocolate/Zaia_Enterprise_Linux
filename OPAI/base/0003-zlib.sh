#!/bin/bash
#name="zlib"
#version"1.2.11"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://zlib.net/zlib-1.2.11.tar.xz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/zlib-1.2.11.tar.xz
cd zlib-1.2.11


mkdir build
cd build


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--prefix=/usr

time make -j24


make  install
rm -fv /usr/lib/libz.a

cd ../../
rm -rf zlib-1.2.11
