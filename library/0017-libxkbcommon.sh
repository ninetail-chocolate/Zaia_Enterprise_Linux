#!/bin/bash
#name="libxkbcommon"
#version="1.4.0"
#zel-version="1"
#comment{
#	"Don't run ninja test on chroot!!"
#}
#src={
#	"https://xkbcommon.org/download/libxkbcommon-1.4.0.tar.xz"
#}
#depend{
#	"xkeyboard-config"
#	"libxcb"
#	"wayland"
#	"wayland-protocols"
#}
#groupdepend{
#		""
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


touch logs/0017-libxkbcommon.log
tar -xf src/libxkbcommon-1.4.0.tar.xz
cd libxkbcommon-1.4.0


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--buildtype=release			\
	-Denable-docs=false			\
	../

ninja


#ninja test | tee ../../logs/0017-libxkbcommon.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf libxkbcommon-1.4.0
