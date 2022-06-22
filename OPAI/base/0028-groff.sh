#!/bin/bash
#name="groff"
#version"1.22.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/groff/groff-1.22.4.tar.gz"
#
#}
#depend{
#	"rpcsvc-proto"
#	"lintirpc"
#	"libtool-GNU"
#	"Cyrus-SASL"
#	"groff"
#	"openSSL"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/groff-1.22.4.tar.gz
cd groff-1.22.4


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
PAGE=A4							\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr

make -j1


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24


cd ../../
rm -rf groff-1.22.4
