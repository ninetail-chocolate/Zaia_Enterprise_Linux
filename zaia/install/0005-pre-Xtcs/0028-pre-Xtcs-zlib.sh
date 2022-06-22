#!/bin/bash
#name="pre-Xtcs-zlib"
#version"1.2.12"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://www.zlib.net/zlib-1.2.12.tar.gz"
#}
#depend{
#	"pre-Xtcs-musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/zlib-1.2.12.tar.gz
cd zlib-1.2.12


mkdir build
cd build
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -isystem="$ZEL" -flto=full "			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -isystem="$ZEL" -flto=full"			\
../configure				\
	--prefix=/usr			\
	--libdir=/usr/lib		\
	--sharedlibdir=/usr/lib		\
	--enable-shared			\
	--64


make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make DESTDIR=$ZEL install


cd ../../
rm -rf zlib-1.2.12
