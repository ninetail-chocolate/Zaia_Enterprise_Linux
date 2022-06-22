#!/bin/bash
#name="iproute2"
#version"1.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.16.0.tar.xz"
#
#}
#depend{
#	"libax25"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0085-libarchive.log
tar -xf src/iproute2-5.16.0.tar.xz
cd iproute2-5.16.0

sed -i /ARPD/d Makefile
#mkdir build
#cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"	\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
make -j24 CC=clang

#make -j24


#make check  | tee ../../logs/0101-gzip.log


make SBINDIR=/usr/sbin install


cd ../
rm -rf iproute2-5.16.0
