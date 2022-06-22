#!/bin/bash
#name="libsndfile"
#version="1.0.31"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libsndfile/libsndfile/releases/download/1.0.31/libsndfile-1.0.31.tar.bz2"
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

touch logs/0032-libsndfile.log
tar -xf src/libsndfile-1.0.31.tar.bz2
cd libsndfile-1.0.31


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


make check -j32 | tee ../../logs/0032-libsndfile.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libsndfile-1.0.31
