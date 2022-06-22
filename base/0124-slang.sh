#!/bin/bash
#name="slang"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.jedsoft.org/releases/slang/slang-2.3.2.tar.bz2"
#}
#depend{
#	"libpng"
#	"pcre"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/slang-2.3.2.tar.bz2
cd slang-2.3.2


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--with-readleine=gnu		\
	--disable-static		\
	--enable-shared

make -j1


#make check -j32 | tee ../../logs/0122-jansson.log


make install


cd ../
rm -rf slang-2.3.2
