#!/bin/bash
#name="expat"
#version"2.4.6"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libexpat/libexpat/releases/download/R_2_4_6/expat-2.4.6.tar.xz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0053-expat.log
tar -xf src/expat-2.4.6.tar.xz
cd expat-2.4.6


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static


make -j24


make check -j1 | tee ../../logs/0053-expat.log


make install -j24


cd ../../
rm -rf expat-2.4.6
