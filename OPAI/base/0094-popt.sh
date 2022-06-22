#!/bin/bash
#name="popt"
#version"1.18"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.rpm.org/popt/releases/popt-1.x/popt-1.18.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0085-libarchive.log
tar -xf src/popt-1.18.tar.gz
cd popt-1.18


#LIBTOOLIZE=libtoolize-GNU	\
sh autogen.sh
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
	--disable-static


make -j24


#make check  | tee ../../logs/0085-libarchive.log


make install


cd ../../
rm -rf popt-1.18
