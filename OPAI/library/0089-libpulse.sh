#!/bin/bash
#name="libpulse"
#version="15.99.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://freedesktop.org/software/pulseaudio/releases/pulseaudio-15.99.1.tar.xz"
#}
#depend{
#	"gdbm"
#
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
tar -xf src/pulseaudio-15.99.1.tar.xz
cd pulseaudio-15.99.1


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
LD=lld						\
CPP=clang-cpp					\
meson						\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--libdir=lib				\
	--localstatedir=/var			\
	--buildtype=release			\
	-Ddocs="disabled"			\
	-Dbluez5=disabled			\
	-Ddatabase=gdbm				\
	-Ddoxygen=false				\
	-Ddaemon=false				\
	../

ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install


cd ../../
rm -rf pulseaudio-15.99.1
