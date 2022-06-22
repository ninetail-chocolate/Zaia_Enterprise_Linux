#!/bin/bash
#name="libtirpc"
#version"1.3.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.2/libtirpc-1.3.2.tar.bz2"
#
#}
#depend{
#	"bzip2"
#	"krb5"or"krb5-minimal"
#	"bsd-compat-headers"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/libtirpc-1.3.2.tar.bz2
cd libtirpc-1.3.2


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
	--sysconfdir=/etc				\
	--disable-static


make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24


cd ../../
rm -rf libtirpc-1.3.2
