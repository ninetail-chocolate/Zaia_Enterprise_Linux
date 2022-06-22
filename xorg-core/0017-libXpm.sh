#!/bin/bash
#name="libXpm"
#version"3.5.13"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/archive//individual/lib/libXpm-3.5.13.tar.bz2"
#}
#depend{
#	"fontconfig"
#	"libxcb"
#	"libXmu"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/libXpm-3.5.13.tar.bz2
cd libXpm-3.5.13


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0014-libXpm.log


make install


cd ../
rm -rf libXpm-3.5.13
