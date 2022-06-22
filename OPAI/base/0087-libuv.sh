#!/bin/bash
#name="libuv"
#version"1.43.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://dist.libuv.org/dist/v1.43.0/libuv-v1.43.0.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0085-libarchive.log
tar -xf src/libuv-v1.43.0.tar.gz
cd libuv-v1.43.0


sh autogen.sh
mkdir build
cd build


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static


make -j24


#make check  | tee ../../logs/0085-libarchive.log


make install


cd ../../
rm -rf libuv-v1.43.0
