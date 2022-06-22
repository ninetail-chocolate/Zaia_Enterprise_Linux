#!/bin/bash
#name="pango"
#version="1.49.4"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/pango/1.49/pango-1.49.4.tar.xz"
#}
#depend{
#	"fontconfig"
#	"freetype"
#	"harfbuzz"
#	"fribidi"
#	"glib"
#	"cairo"
#	"gobject-introspection"
#	"json-glib"
#	"xorg-server"
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
tar -xf src/pango-1.49.4.tar.xz
cd pango-1.49.4


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
	--wrap-mode=nofallback			\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf pango-1.49.4
