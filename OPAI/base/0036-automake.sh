#!/bin/bash
#name="automake"
#version"1.16.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/automake/automake-1.16.5.tar.xz"
#
#}
#depend{
#	"autoconf"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0037-automake.log
tar -xf src/automake-1.16.5.tar.xz
cd automake-1.16.5


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


make check -j24 | tee ../../logs/0037-automake.log


make install -j24


cd ../../
rm -rf automake-1.16.5
