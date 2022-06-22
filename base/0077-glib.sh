#!/bin/bash
#name="glib"
#version"2.70.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.gnome.org/sources/glib/2.70/glib-2.70.4.tar.xz"
#
#}
#depend{
#	"libxslt"
#	"pcre"
#	"ninja"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0075-libxslt.log
tar -xf src/glib-2.70.4.tar.xz
cd glib-2.70.4


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
meson							\
	--prefix=/usr					\
	--buildtype=release				\
	-Dman=false					\
	-Dtests=false					\
	..


ninja



#make check | tee ../../logs/0075-libxslt.log


ninja install


cd ../../
rm -rf glib-2.70.4
