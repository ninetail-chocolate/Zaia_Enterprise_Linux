#!/bin/bash
#name="cairo"
#version="1.17.4"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://www.cairographics.org/snapshots/cairo-1.17.4.tar.xz"
#}
#depend{
#	"libpng"
#	"pixman"
#	"fontconfig"
#	"glib"
#	"xorg-server"
#	"mesa"
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
tar -xf src/cairo-1.17.4.tar.xz
cd cairo-1.17.4


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
	--enable-tee				\
	--enable-xlib-xcb			\
	--enable-gl


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf cairo-1.17.4
