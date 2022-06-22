#!/bin/bash
#name="cpio"
#version"2.13"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.gnu.org/gnu/cpio/cpio-2.13.tar.bz2"
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


tar -xf src/cpio-2.13.tar.bz2
cd cpio-2.13


sed -i '/The name/,+2 d' src/global.c
./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--prefix=/usr				\
	--enable-largefile			\
	--enable-mt				\
	--with-rmt=/usr/libexec/rmt

make -j32


make check -j32 | tee ../logs/0110-cpio.log


make install


cd ../
rm -rf cpio-2.13
