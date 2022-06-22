#!/bin/bash
#name="autoconf2.13"
#version"2.13"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.gnu.org/gnu/autoconf/autoconf-2.13.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0036-autoconf.log
tar -xf src/autoconf-2.13.tar.gz
cd autoconf-2.13


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
	--program-suffix=2.13


make


#TESTSUITEFLAGS=-j24 make check| tee ../../logs/0036-autoconf.log


make install -j24


cd ../../
rm -rf autoconf-2.13
