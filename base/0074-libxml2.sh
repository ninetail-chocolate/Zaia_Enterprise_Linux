#!/bin/bash
#name="libxml2"
#version"2.9.13"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.13.tar.xz"
#
#}
#depend{
#	"icu"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0072-ICU.log
tar -xf src/libxml2-2.9.13.tar.xz
cd libxml2-2.9.13


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
	--disable-static				\
	--with-history					\
	--with-python=/usr/bin/python3


make -j24


#make check | tee ../../logs/0072-ICU.log


make install


cd ../../
rm -rf libxml2-2.9.13
