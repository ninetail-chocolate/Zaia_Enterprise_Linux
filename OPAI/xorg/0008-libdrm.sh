#!/bin/bash
#name="libdrm"
#version"2.4.110"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://dri.freedesktop.org/libdrm/libdrm-2.4.110.tar.xz"
#}
#depend{
#	"cmake"
#	"libatomic_ops"
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

tar -xf src/libdrm-2.4.110.tar.xz
cd libdrm-2.4.110


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC "		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson	--buildtype=release		\
	-Dudev=true			\
	-Dvalgrind=false		\
	-Dnouveau=false			\
	-Dvmwgfx=true			\
	--prefix=$XORG_PREFIX		\
../


ninja


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


ninja install


cd ../../
rm -rf libdrm-2.4.110
