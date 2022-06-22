#!/bin/bash
#name="xz"
#version"5.3.2alpha"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://tukaani.org/xz/xz-5.3.2alpha.tar.xz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0005-xz.log
tar -xf src/xz-5.3.2alpha.tar.xz
cd xz-5.3.2alpha


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--disable-static			\


time make -j24


time make check -j24 | tee ../../logs/0005-xz.log


time make install


cd ../../
rm -rf xz-5.3.2alpha
