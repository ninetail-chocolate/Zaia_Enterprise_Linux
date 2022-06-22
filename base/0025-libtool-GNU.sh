#!/bin/bash
#name="libltdl"
#version"2.0.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/libtool/libtool-2.4.6.tar.xz"
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
tar -xf src/libtool-2.4.6.tar.xz
cd libtool-2.4.6


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr


make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24


cd ../../
rm -rf libtool-2.4.6
