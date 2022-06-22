#!/bin/bash
#name="dbus-glib"
#version="0.112"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.112.tar.gz"
#}
#depend{
#	"dbus"
#	"glib"
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
tar -xf src/dbus-glib-0.112.tar.gz
cd dbus-glib-0.112


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
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf dbus-glib-0.112
