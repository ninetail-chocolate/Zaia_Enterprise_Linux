#!/bin/bash
#name="xorgproto"
#version"2021.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2021.5.tar.gz"
#}
#depend{
#	"util-macros"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/xorgproto-2021.5.tar.gz
cd xorgproto-2021.5


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


#make check -j32 | tee ../logs/0128-fontconfig.log


make install


cd ../
rm -rf xorgproto-2021.5
