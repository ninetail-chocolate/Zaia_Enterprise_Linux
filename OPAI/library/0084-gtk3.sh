#!/bin/bash
#name="gtk3"
#version="3.24.33"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/gtk+/3.24/gtk%2B-3.24.33.tar.xz"
#}
#depend{
#	"at-spi2-atk"
#	"gdk-pixbuf"
#	"libeproxy"
#	"pango"
#	"adwaita-icon-theme"
#	"hicolor-icon-theme"
#	"isocodes"
#	"libxkbcommon"
#	"sassc"
#	"wayland"
#	"wayland-protocols"
#	"gobject-introspection"
#	"cups"
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
tar -xf src/gtk+-3.24.33.tar.xz
cd gtk+-3.24.33


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--enable-shared				\
	--disable-static			\
	--enable-broadway-backend		\
	--enable-x11-backend			\
	--enable-wayland-backend


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf gtk+-3.24.33
