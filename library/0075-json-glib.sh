#!/bin/bash
#name="json-glib"
#version="1.6.6"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/json-glib/1.6/json-glib-1.6.6.tar.xz"
#}
#depend{
#	"glib"
#	"gobject-introspection
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
tar -xf src/json-glib-1.6.6.tar.xz
cd json-glib-1.6.6


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
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf json-glib-1.6.6
