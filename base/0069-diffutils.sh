#!/bin/bash
#name="diffutils"
#version"3.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/diffutils/diffutils-3.8.tar.xz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0068-diffutils.log
tar -xf src/diffutils-3.8.tar.xz
cd diffutils-3.8


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
FORCE_UNSAFE_CONFIGURE=1				\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static


make -j24


make check | tee ../../logs/0068-diffutils.log


make install


cd ../../
rm -rf diffutils-3.8
