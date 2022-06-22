#!/bin/bash
#name="tar"
#version"1.34"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/tar/tar-1.34.tar.xz"
#}
#depend{
#	"musl"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/tar-1.34.tar.xz
cd tar-1.34


mkdir build
cd build

FORCE_UNSAFE_CONFIGURE=1		\
../configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr


make -j32


make check -j32 | tee ../../logs/0116-tar.log


make install


cd ../../
rm -rf tar-1.34
