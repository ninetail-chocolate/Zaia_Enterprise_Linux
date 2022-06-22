#!/bin/bash
#name="libeproxy"
#version"1.5.9"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/anholt/libepoxy/releases/download/1.5.9/libepoxy-1.5.9.tar.xz"
#}
#depend{
#	"mesa"
#}
#groupdepend{
#		""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile.d/xorg.sh

tar -xf src/libepoxy-1.5.9.tar.xz
cd libepoxy-1.5.9


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson	--buildtype=release		\
	--prefix=/usr		\
../


ninja


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


ninja install


cd ../../
rm -rf libepoxy-1.5.9
