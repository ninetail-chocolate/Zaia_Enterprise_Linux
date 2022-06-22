#!/bin/bash
#name="python3-minimal"
#version"3.10.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tar.xz"
#
#}
#depend{
#	"libtool-GNU"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/Python-3.10.2.tar.xz
cd Python-3.10.2


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
	--disable-static			\
	--with-system-expat			\
	--with-system-ffi			\
	--with-ensurepip=yes

make -j24

#mkdir -pv /usr/base/oppai/DT
#make DESTDIR=/usr/base/oppai/DT install
#make check -j1 | tee ../../logs/0058-intltool.log


make install -j24


cd ../../
rm -rf Python-3.10.2
