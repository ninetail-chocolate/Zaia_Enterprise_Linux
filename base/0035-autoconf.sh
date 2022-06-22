#!/bin/bash
#name="autoconf"
#version"2.71"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/autoconf/autoconf-2.71.tar.xz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0036-autoconf.log
tar -xf src/autoconf-2.71.tar.xz
cd autoconf-2.71


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr


TESTSUITEFLAGS=-j24 make check| tee ../../logs/0036-autoconf.log


make install -j24


cd ../../
rm -rf autoconf-2.71
