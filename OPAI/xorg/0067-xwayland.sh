#!/bin/bash
#name="xwayland"
#version"22.1.0"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://xorg.freedesktop.org/archive/individual/xserver/xwayland-22.1.0.tar.xz"
#}
#depend{
#	"meson"
#	"wayland"
#	"libeproxy"
#	"libdrm"
#}
#groupdepend{
#		"xorg-core"
#	}
#replace{
#	""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile.d/xorg.sh

tar -xf src/xwayland-22.1.0.tar.xz
cd xwayland-22.1.0


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--libdir=lib				\
	--localstatedir=/var			\
	--buildtype=release			\
	-Dxvfd=false				\
	-Dxkb_output_dir=/var/lib/xkb		\
	../



ninja


#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install


cd ../../
rm -rf xwayland-22.1.0
