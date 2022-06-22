#!/bin/bash
#name="flex"
#version"2.6.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz"
#}
#depend{
#	"m4"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0011-flex.log
tar -xf src/flex-2.6.4.tar.gz
cd flex-2.6.4


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
	--disable-static

time make -j24


time make check -j24 | tee ../../logs/0011-flex.log


time make install
ln -sv flex /usr/bin/lex


cd ../../
rm -rf flex-2.6.4
