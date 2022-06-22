#!/bin/bash
#name="libXt"
#version"1.2.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/archive//individual/lib/libXt-1.2.1.tar.bz2"
#}
#depend{
#	"fontconfig"
#	"libxcb"
#	"libXScrnSaver"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/libXt-1.2.1.tar.bz2
cd libXt-1.2.1


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0014-libXt.log


make install


cd ../
rm -rf libXt-1.2.1
