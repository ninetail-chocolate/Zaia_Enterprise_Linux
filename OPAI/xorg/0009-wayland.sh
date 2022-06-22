#!/bin/bash
#name="wayland"
#version"1.20"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://wayland.freedesktop.org/releases/wayland-1.20.0.tar.xz"
#}
#depend{
#	"libxml2"
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

tar -xf src/wayland-1.20.0.tar.xz
cd wayland-1.20.0


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC "		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson	--buildtype=release		\
	-Ddocumentation=false		\
	--prefix=/usr		\
../


ninja


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


ninja install


cd ../../
rm -rf wayland-1.20.0
