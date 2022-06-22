#!/bin/bash
#name="libnotify"
#version="0.7.9"
#zel-version="1"
#comment{
#	"check it. https://wiki.linuxfromscratch.org/blfs/wiki/libnotify"
#}
#src={
#	"https://download.gnome.org/sources/libnotify/0.7/libnotify-0.7.9.tar.xz"
#}
#depend{
#	"gkt3"
#	"gobject-introspectioin"
#	"notification-daemon"
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


#touch logs/0038-libvpx.log
tar -xf src/libnotify-0.7.9.tar.xz
cd libnotify-0.7.9


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--libdir=lib				\
	--buildtype=release			\
	-Dgtk_doc=false				\
	-Dman=false				\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install


cd ../../
rm -rf libnotify-0.7.9
