#!/bin/bash
#name="mesa"
#version"22.0.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mesa3d.org//mesa-22.0.0.tar.xz"
#}
#depend{
#	"libdrm"
#	"Mako"
#	"libva-minimal"
#	"wayland-protocols"
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

tar -xf src/mesa-22.0.0.tar.xz
cd mesa-22.0.0


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target="x86_64-zel-linux-musl""		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target="x86_64-zel-linux-musl""		\
meson								\
	--prefix=$XORG_PREFIX					\
	--buildtype=release					\
	-Dplatforms="x11,wayland"				\
	-Degl-native-platform="wayland"				\
	-Dgallium-drivers="i915,radeonsi,virgl,swrast"		\
	-Dgallium-opencl="disabled"				\
	-Dgallium-nine="false"					\
	-Dglx="dri"						\
	-Dglx-direct="true"					\
	-Degl="enabled"						\
	-Ddri3="enabled"					\
	-Dvalgrind="disabled"					\
	-Dlibunwind="disabled"					\
	-Dvulkan-drivers="swrast"				\
	-Dglx="dri"						\
	-Dgles1=disabled					\
	-Dgles2="enabled"					\
	-Dllvm="enabled"					\
../


ninja


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


ninja install


cd ../../
rm -rf mesa-22.0.0
