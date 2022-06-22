#!/bin/bash
#name="bc"
#version"5.2.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/gavinhoward/bc/releases/download/5.2.2/bc-5.2.2.tar.xz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0010-bc.log
tar -xf src/bc-5.2.2.tar.xz
cd bc-5.2.2


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--prefix=/usr				\
	-G


time make -j24


time make test -j24 | tee ../../logs/0010-bc.log


time make install


cd ../../
rm -rf bc-5.2.2
