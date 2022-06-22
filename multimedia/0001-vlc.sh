#!/bin/bash
#name="vlc"
#version="3.0.17.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.videolan.org/vlc/3.0.17.3/vlc-3.0.17.3.tar.xz"
#	"https://code.videolan.org/videolan/vlc/-/merge_requests/1238.patch"
#}
#depend{
#	"musl"
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
tar -xf src/vlc-3.0.17.3.tar.xz
cd vlc-3.0.17.3


patch -Np1 -i ../src/1238.patch
autoreconf -fi
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
BUILDCC=clang					\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--disable-optimizations			\
	--enable-libva				\
	--disable-lua				\
	--disable-opencv			\
	--enable-a52				\
	--disable-dav1d				\
	--disable-aom				\
	--enable-wayland


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf vlc-3.0.17.3
