#!/bin/bash
#name="libXcomposite"
#version"0.4.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/archive//individual/lib/libXcomposite-0.4.5.tar.bz2"
#}
#depend{
#	"fontconfig"
#	"libxcb"
#	"libXfixes"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile

tar -xf src/libXcomposite-0.4.5.tar.bz2
cd libXcomposite-0.4.5


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0020-libXcomposite.log


make install


cd ../
rm -rf libXcomposite-0.4.5
