#!/bin/bash
#name="pixman"
#version"0.40.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.cairographics.org/releases/pixman-0.40.0.tar.gz"
#}
#depend{
#	"libpng"
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

tar -xf src/pixman-0.40.0.tar.gz
cd pixman-0.40.0


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
rm -rf pixman-0.40.0
