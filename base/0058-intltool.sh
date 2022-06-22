#!/bin/bash
#name="intltool"
#version"0.51.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz"
#
#}
#depend{
#	"XML::Parser"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0058-intltool.log
tar -xf src/intltool-0.51.0.tar.gz
cd intltool-0.51.0


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
	--enable-shared				\
	--disable-static


make -j24


make check -j1 | tee ../../logs/0058-intltool.log


make install -j24


cd ../../
rm -rf intltool-0.51.0
