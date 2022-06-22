#!/bin/bash
#name="xcb-proto"
#version"1.14.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-1.14.1.tar.xz"
#}
#depend{
#	"xorgproto"
#	"libxml"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile


tar -xf src/xcb-proto-1.14.1.tar.xz
cd xcb-proto-1.14.1


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0006-xcb-proto.log


make install


cd ../
rm -rf xcb-proto-1.14.1
