#!/bin/bash
#name="libXi"
#version"1.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/archive//individual/lib/libXi-1.8.tar.bz2"
#}
#depend{
#	"fontconfig"
#	"libxcb"
#	"libXft"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/libXi-1.8.tar.bz2
cd libXi-1.8


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0027-libXi.log


make install


cd ../
rm -rf libXi-1.8
