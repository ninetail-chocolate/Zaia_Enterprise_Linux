#!/bin/bash
#name="xcb-util-renderutil"
#version"0.3.9"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.gz"
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

source /etc/profile.d/xorg.sh

tar -xf src/xcb-util-renderutil-0.3.9.tar.gz
cd xcb-util-renderutil-0.3.9


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	$XORG_CONFIG

make 


make check -j32 | tee ../logs/0010-xcb-util-renderutil.log


make install


cd ../
rm -rf xcb-util-renderutil-0.3.9
