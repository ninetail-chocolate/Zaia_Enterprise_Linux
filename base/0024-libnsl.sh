#!/bin/bash
#name="libnsl"
#version"2.0.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/thkukuk/libnsl/releases/download/v2.0.0/libnsl-2.0.0.tar.xz"
#
#}
#depend{
#	"rpcsvc-proto"
#	"lintirpc"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/libnsl-2.0.0.tar.xz
cd libnsl-2.0.0


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
	--disable-static


make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24


cd ../../
rm -rf libnsl-2.0.0
