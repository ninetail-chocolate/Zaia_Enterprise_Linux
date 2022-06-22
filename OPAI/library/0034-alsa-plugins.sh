#!/bin/bash
#name="alsa-plugins"
#version="1.2.6"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.alsa-project.org/files/pub/plugins/alsa-plugins-1.2.6.tar.bz2"
#}
#depend{
#	"alsa-lib"
#	"libsamplerate"
#	"speex"
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

#touch logs/0033-libsamplerate.log
tar -xf src/alsa-plugins-1.2.6.tar.bz2
cd alsa-plugins-1.2.6

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


#make check -j32 | tee ../../logs/0033-libsamplerate.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf alsa-plugins-1.2.6
