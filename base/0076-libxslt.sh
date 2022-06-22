#!/bin/bash
#name="libxslt"
#version"2.21"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.35.tar.xz"
#
#}
#depend{
#	"libxml2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0075-libxslt.log
tar -xf src/libxslt-1.1.35.tar.xz
cd libxslt-1.1.35


sed -i s/3000/5000/ libxslt/transform.c doc/xsltproc.{1,xml}
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
	--without-python

make -j24



#make check | tee ../../logs/0075-libxslt.log


make install


cd ../../
rm -rf libxslt-1.1.35
