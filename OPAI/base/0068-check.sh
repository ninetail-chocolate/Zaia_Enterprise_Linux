#!/bin/bash
#name="check"
#version"0.15.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libcheck/check/releases/download/0.15.2/check-0.15.2.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0067-check.log
tar -xf src/check-0.15.2.tar.gz
cd check-0.15.2


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
FORCE_UNSAFE_CONFIGURE=1				\
LIBTOOL=libtool-GNU					\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static


make -j24


#make check | tee ../../logs/0067-check.log


make install


cd ../../
rm -rf check-0.15.2
