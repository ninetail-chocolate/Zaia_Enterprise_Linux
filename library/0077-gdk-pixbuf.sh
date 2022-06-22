#!/bin/bash
#name="gdk-pixbuf"
#version="2.42.8"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.8.tar.xz"
#}
#depend{
#	"glib"
#	"libjpeg-turbo"
#	"libpng"
#	"shared-mime-info"
#	"libtiff"
#	"gobject-introspection"
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
tar -xf src/gdk-pixbuf-2.42.8.tar.xz
cd gdk-pixbuf-2.42.8


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
rm -rf gdk-pixbuf-2.42.8
