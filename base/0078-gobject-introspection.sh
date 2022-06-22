#!/bin/bash
#name="gobject-introspection"
#version"1.71.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.gnome.org/sources/gobject-introspection/1.71/gobject-introspection-1.71.0.tar.xz"
#
#}
#depend{
#	"glib"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0075-libxslt.log
tar -xf src/gobject-introspection-1.71.0.tar.xz
cd gobject-introspection-1.71.0


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
meson							\
	--prefix=/usr					\
	--buildtype=release				\
	..


ninja


#make check | tee ../../logs/0075-libxslt.log


ninja install


cd ../../
rm -rf gobject-introspection-1.71.0
