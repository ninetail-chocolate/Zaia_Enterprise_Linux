#!/bin/bash
#name="libical"
#version="3.0.14"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libical/libical/releases/download/v3.0.14/libical-3.0.14.tar.gz"
#}
#depend{
#	"cmake"
#	"ninja"
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

source /etc/profile

#touch logs/0045-libical.log
tar -xf src/libical-3.0.14.tar.gz
cd libical-3.0.14


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_INSTALL_LIBDIR=lib		\
	-DCMAKE_BUILD_TYPE=Release		\
	-DSHARED_ONLY=yes			\
	-DICAL_BUILD_DOCS=false			\
	-DGOBJECT_INTROSPECTION=true		\
	-DICAL_GLIB_VAPI=false			\
	-G Ninja				\
	../

ninja -j1


#ninja test -j32 | tee ../../logs/0045-libical.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf libical-3.0.14
