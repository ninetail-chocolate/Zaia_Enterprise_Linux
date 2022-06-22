#!/bin/bash
#name="newt"
#version"0.52.21"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://releases.pagure.org/newt/newt-0.52.21.tar.gz"
#}
#depend{
#	"popt"
#	"slang"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/newt-0.52.21.tar.gz
cd newt-0.52.21


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--with-python=python3.10

make 


#make check -j32 | tee ../logs/0122-jansson.log


make install


cd ../
rm -rf newt-0.52.21
