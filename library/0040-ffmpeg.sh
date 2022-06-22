#!/bin/bash
#name="ffmpeg"
#version="5.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ffmpeg.org/releases/ffmpeg-5.0.tar.xz"
#}
#depend{
#	"libass"
#	"fdk-aac"
#	"freetype"
#	"lame"
#	"libtheora"
#	"libvorbis"
#	"libvpx"
#	"opus"
#	"nasm"
#	"yasm"
#	"libdrm"
#	"alas-lib"
#	"libva"
#	"fribidi"
#	"libwebp"
#	"openjpeg"
#	"gnutls"
#	"speex"
#	"xvid"
#	"libva"
#	"xorg-server"
#	"dav1d"
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
tar -xf src/ffmpeg-5.0.tar.xz
cd ffmpeg-5.0


sed -i 's/-lflite"/-lflite -lasound"/' configure
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--cc=clang				\
	--cxx=clang++				\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--enable-version3		\
	--disable-debug			\
	--enable-libass			\
	--enable-libfdk-aac	\
	--enable-libfreetype	\
	--enable-libmp3lame 	\
	--enable-libopus	\
	--enable-libtheora	\
	--enable-libvorbis	\
	--enable-libvpx		\
	--enable-libdrm		\
	--enable-openssl	\
	--enable-vaapi		\
	--enable-libdav1d	\
	--enable-xlib

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf ffmpeg-5.0
