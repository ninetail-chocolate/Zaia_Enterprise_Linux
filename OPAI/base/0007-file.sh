#!/bin/bash
#name="file"
#version"5.41"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://astron.com/pub/file/file-5.41.tar.gz"
#}
#depend{
#	"bzip2"
#	"xz"
#	"zlib"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0007-file.log
tar -xf src/file-5.41.tar.gz
cd file-5.41


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


time make -j24


time make check -j24 | tee ../../logs/0007-file.log


time make install


cd ../../
rm -rf file-5.41
