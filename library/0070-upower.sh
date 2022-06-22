#!/bin/bash
#name="upower"
#version="0.99.17"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://gitlab.freedesktop.org/upower/upower/-/archive/v0.99.17/upower-v0.99.17.tar.bz2"
#}
#depend{
#	"libgudev"
#	"libusb"
#	"polkit"
#	"gobject-introspection"
#	"gkt-doc"
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
tar -xf src/upower-v0.99.17.tar.bz2
cd upower-v0.99.17


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--libdir=lib				\
	--localstatedir=/var			\
	-Dudevrulesdir=/lib/udev/rules.d	\
	-Dsystemdsystemunitdir=no		\
	-Dgtk-doc=false				\
	-Dman=true				\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf upower-v0.99.17
