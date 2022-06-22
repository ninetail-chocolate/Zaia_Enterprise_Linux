#!/bin/bash
#name="wayland-protocols"
#version"1.25"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://wayland.freedesktop.org/releases/wayland-protocols-1.25.tar.xz"
#}
#depend{
#	"wayland"
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

tar -xf src/wayland-protocols-1.25.tar.xz
cd wayland-protocols-1.25


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target="x86_64-zel-linux-musl""		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target="x86_64-zel-linux-musl""		\
meson	--buildtype=release		\
	--prefix=/usr			\
../


ninja


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


ninja install


cd ../../
rm -rf wayland-protocols-1.25
