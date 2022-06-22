#!/bin/bash
#name="libcap-ng"
#version"0.8.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://people.redhat.com/sgrubb/libcap-ng/libcap-ng-0.8.2.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0031-libcap-ng.log
tar -xf src/libcap-ng-0.8.2.tar.gz
cd libcap-ng-0.8.2


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-static=no			\
	--without-python			\
	--with-python3


make -j24


make check -j24 | tee ../../logs/0031-libcap-ng.log


make install -j24


cd ../../
rm -rf libcap-ng-0.8.2
