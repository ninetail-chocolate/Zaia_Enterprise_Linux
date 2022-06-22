#!/bin/bash
#name="libvorbis"
#version="1.3.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.tar.xz"
#}
#depend{
#	"libogg"
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

#touch logs/0029-libvorbis.log
tar -xf src/libvorbis-1.3.7.tar.xz
cd libvorbis-1.3.7


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_INSTALL_LIBDIR=lib		\
	-DBUILD_SHARED_LIBS=True		\
	-DCMAKE_BUILD_TYPE=Release		\
	-G Ninja				\
	../

ninja -j32


#ninja test -j32 | tee ../../logs/0029-libvorbis.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf libvorbis-1.3.7
