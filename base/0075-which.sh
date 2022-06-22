#!/bin/bash
#name="which"
#version"2.21"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.gnu.org/gnu/which/which-2.21.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0072-ICU.log
tar -xf src/which-2.21.tar.gz
cd which-2.21


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


#make check | tee ../../logs/0072-ICU.log


make install


cd ../../
rm -rf which-2.21
