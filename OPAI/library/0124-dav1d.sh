#!/bin/bash
#name="dav1d"
#version="1.0.0"
#zel-version="1"
#comment{
#	"check it. https://wiki.linuxfromscratch.org/blfs/wiki/libnotify"
#}
#src={
#	"https://code.videolan.org/videolan/dav1d/-/archive/1.0.0/dav1d-1.0.0.tar.bz2"
#}
#depend{
#	"ninja"
#	"meson"
#	"xxhash"
#	"graphviz"
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
tar -xf src/dav1d-1.0.0.tar.bz2
cd dav1d-1.0.0


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--libdir=lib				\
	--buildtype=release			\
	-Dman=false				\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install


cd ../../
rm -rf dav1d-1.0.0
