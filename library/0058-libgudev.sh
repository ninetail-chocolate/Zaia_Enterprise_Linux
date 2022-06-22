#!/bin/bash
#name="libgudev"
#version="237"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/libgudev/237/libgudev-237.tar.xz"
#}
#depend{
#	"glib"
#	"gobject-introspection"
#	"eudev"
#	"pcre"
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


source /etc/profile

#touch logs/0038-libvpx.log
tar -xf src/libgudev-237.tar.xz
cd libgudev-237


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
PYTHON=/usr/bin/python3				\
meson						\
	--prefix=/usr				\
	--libdir=lib				\
	--buildtype="release"			\
	../

ninja -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf libgudev-237
