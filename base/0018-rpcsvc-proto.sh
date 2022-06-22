#!/bin/bash
#name="rpcsvc-proto"
#version"1.4.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/thkukuk/rpcsvc-proto/releases/download/v1.4.3/rpcsvc-proto-1.4.3.tar.xz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0018-rpcsvc-proto.log
tar -xf src/rpcsvc-proto-1.4.3.tar.xz
cd rpcsvc-proto-1.4.3



mkdir build
cd build

CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--sysconfdir=/etc


make -j24


make check -j24 | tee ../../logs/0018-rpcsvc-proto.log


make install -j24


cd ../../
rm -rf rpcsvc-proto-1.4.3
