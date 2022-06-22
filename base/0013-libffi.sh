#!/bin/bash
#name="libffi"
#version"3.4.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libffi/libffi/releases/download/v3.4.2/libffi-3.4.2.tar.gz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0013-libffi.log
tar -xf src/libffi-3.4.2.tar.gz
cd libffi-3.4.2


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
	--disable-exec-static-tramp

time make -j24


time make install


cd ../../
rm -rf libffi-3.4.2
