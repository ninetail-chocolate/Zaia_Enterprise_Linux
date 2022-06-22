#!/bin/bash
#name="libXext"
#version"1.3.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://xorg.freedesktop.org/archive/individual/lib/libXext-1.3.4.tar.bz2"
#}
#depend{
#	"fontconfig"
#	"libxcb"
#	"libX11"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/libXext-1.3.4.tar.bz2
cd libXext-1.3.4


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0010-libXext.log


make install


cd ../
rm -rf libXext-1.3.4
