#!/bin/bash
#name="libpipeline"
#version"1.5.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://download.savannah.nongnu.org/releases/libpipeline/libpipeline-1.5.5.tar.gz"
#}
#depend{
#	"pkg-config"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/libpipeline-1.5.5.tar.gz
cd libpipeline-1.5.5


sed -i '/The name/,+2 d' src/global.c
./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--prefix=/usr


make -j32


make check -j32 | tee ../logs/0113-libpipeline.log


make install


cd ../
rm -rf libpipeline-1.5.5
