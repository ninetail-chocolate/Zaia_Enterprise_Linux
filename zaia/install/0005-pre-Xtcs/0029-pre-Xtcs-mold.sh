#!/bin/bash
#name="pre-Xtcs-mold"
#version"1.1.1"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"wget -O mold-1.1.1.tar.gz https://github.com/rui314/mold/archive/refs/tags/v1.1.1.tar.gz"
#}
#depend{
#	"pre-Xtcs-zlib"
#	"pre-Xtcs-OpenSSL"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/mold-1.1.1.tar.gz
cd mold-1.1.1

make					\
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -D_LIBCPP_HAS_MUSL_LIBC --sysroot="$ZEL" -isystem="$ZEL" -flto=full "			\
CXX=clang++				\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -D_LIBCPP_HAS_MUSL_LIBC --sysroot="$ZEL" -isystem="$ZEL" -flto=full"			\
PREFIX=/usr -j32



#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
#make DESTDIR=$ZEL install


cd ../
rm -rf mold-1.1.1
