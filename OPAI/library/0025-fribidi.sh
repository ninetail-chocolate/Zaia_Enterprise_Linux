#!/bin/bash
#name="fribidi"
#version="1.0.11"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/fribidi/fribidi/releases/download/v1.0.11/fribidi-1.0.11.tar.xz"
#}
#depend{
#	"meson"
#	"ninja"
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

touch logs/0025-fribidi.log
tar -xf src/fribidi-1.0.11.tar.xz
cd fribidi-1.0.11


mkdir bld
cd bld

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson				\
	--prefix=/usr		\
	--libdir=lib		\
	--buildtype=release	\
	../

ninja


ninja test | tee ../../logs/0025-fribidi.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf fribidi-1.0.11
