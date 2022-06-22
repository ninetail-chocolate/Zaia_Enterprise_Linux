#!/bin/bash
#name="libxcvt"
#version"0.1.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/pub/individual/lib/libxcvt-0.1.1.tar.xz"
#}
#depend{
#	"musl"
#}
#groupdepend{
#		"xorg-core"
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile.d/xorg.sh

tar -xf src/libxcvt-0.1.1.tar.xz
cd libxcvt-0.1.1


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
rm -rf libxcvt-0.1.1
