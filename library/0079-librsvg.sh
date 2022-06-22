#!/bin/bash
#name="librsvg"
#version="2.52.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/librsvg/2.52/librsvg-2.52.0.tar.xz"
#}
#depend{
#	"gdk-pixbuf"
#	"cairo"
#	"pango"
#	"rustc"
#	"gobject-introspection"
#	"python3-docutils"
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
tar -xf src/librsvg-2.52.0.tar.xz
cd librsvg-2.52.0


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
PYTHON=/usr/bin/python3				\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--disable-vala


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf librsvg-2.52.0
