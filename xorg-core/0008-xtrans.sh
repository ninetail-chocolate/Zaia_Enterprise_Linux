#!/bin/bash
#name="xtrans"
#version"1.4.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://xorg.freedesktop.org/archive/individual/lib/xtrans-1.4.0.tar.bz2"
#}
#depend{
#	"libxcb"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/xtrans-1.4.0.tar.bz2
cd xtrans-1.4.0


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0008-xtrans.log


make install


cd ../
rm -rf xtrans-1.4.0
