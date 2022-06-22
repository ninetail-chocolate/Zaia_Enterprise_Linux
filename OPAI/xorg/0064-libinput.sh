#!/bin/bash
#name="libinput"
#version"1.19.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.freedesktop.org/software/libinput/libinput-1.19.1.tar.xz"
#}
#depend{
#	"libevdev"
#	"mtdev"
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

tar -xf src/libinput-1.19.1.tar.xz
cd libinput-1.19.1


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson	--buildtype=release		\
	--prefix=/usr			\
	-Ddebug-gui=false		\
	-Dtests=false			\
	-Dlibwacom=false		\
../


ninja


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


ninja install


cd ../../
rm -rf libinput-1.19.1
