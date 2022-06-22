#!/bin/bash
#name="ICU"
#version"70.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/unicode-org/icu/releases/download/release-70-1/icu4c-70_1-src.tgz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0072-ICU.log
tar -xf src/icu4c-70_1-src.tgz
cd icu

cd source
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


make check | tee ../../../logs/0072-ICU.log


make install


cd ../../../
rm -rf icu
