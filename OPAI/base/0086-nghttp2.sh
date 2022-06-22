#!/bin/bash
#name="nghttp2"
#version"1.46.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/nghttp2/nghttp2/releases/download/v1.46.0/nghttp2-1.46.0.tar.xz"
#
#}
#depend{
#	"libxml2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0085-libarchive.log
tar -xf src/nghttp2-1.46.0.tar.xz
cd nghttp2-1.46.0


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
	--disable-static				\
	--enable-lib-only

make -j24


#make check  | tee ../../logs/0085-libarchive.log


make install


cd ../../
rm -rf nghttp2-1.46.0
