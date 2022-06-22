#!/bin/bash
#name="swig"
#version"4.0.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.sourceforge.net/swig/swig-4.0.2.tar.gz"
#
#}
#depend{
#	"pcre"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0032-pcre.log
tar -xf src/swig-4.0.2.tar.gz
cd swig-4.0.2


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--without-maximum-compile-warnings

make -j24


#make check -j24 | tee ../../logs/0032-pcre.log


make install -j24


cd ../../
rm -rf swig-4.0.2
