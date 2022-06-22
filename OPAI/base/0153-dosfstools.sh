#!/bin/bash
#name="dosfstools"
#version"4.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget https://github.com/dosfstools/dosfstools/releases/download/v4.2/dosfstools-4.2.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/dosfstools.log
tar -xf src/dosfstools-4.2.tar.gz
cd dosfstools-4.2


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
	--bindir=/usr/bin			\
	--sbindir=/usr/sbin			\
	--sysconfdir=/etc			\
	--localstatedir=/var			\
	--mandir=/usr/share/man			\
	--enable-shared				\
	--disable-static			\
	--enable-compat-symlinks


make -j32


make -j32 check | tee ../../logs/dosfstools.log


make install -j24


cd ../../
rm -rf dosfstools-4.2
