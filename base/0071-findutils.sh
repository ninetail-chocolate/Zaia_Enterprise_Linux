#!/bin/bash
#name="findutils"
#version"4.9.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/findutils/findutils-4.9.0.tar.xz"
#
#}
#depend{
#	"libselinux"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0069-gawk.log
tar -xf src/findutils-4.9.0.tar.xz
cd findutils-4.9.0


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
	--enable-shared					\
	--disable-static				\
	--localstatedir=/var/lib/locate


make -j24


#make check | tee ../../logs/0069-gawk.log


make install


cd ../../
rm -rf findutils-4.9.0
