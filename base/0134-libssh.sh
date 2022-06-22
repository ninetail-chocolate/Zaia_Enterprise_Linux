#!/bin/bash
#name="libssh2"
#version"1.10.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.libssh2.org/download/libssh2-1.10.0.tar.gz"
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


tar -xf src/libssh2-1.10.0.tar.gz
cd libssh2-1.10.0


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--localstatedir=/var		\
	--disable-static		\
	--enable-shared

make 


#make check -j32 | tee ../logs/0128-fontconfig.log


make install


cd ../
rm -rf libssh2-1.10.0
