#!/bin/bash
#name="libsamplerate"
#version="0.2.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libsndfile/libsamplerate/releases/download/0.2.2/libsamplerate-0.2.2.tar.xz"
#}
#depend{
#	"libogg"
#	"flac"
#	"libvorbis"
#	"alsa-lib"
#	"speex"
#	"sqlite"
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

touch logs/0033-libsamplerate.log
tar -xf src/libsamplerate-0.2.2.tar.xz
cd libsamplerate-0.2.2


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static

make -j32


make check -j32 | tee ../../logs/0033-libsamplerate.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libsamplerate-0.2.2
