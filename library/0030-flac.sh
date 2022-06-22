#!/bin/bash
#name="flac"
#version="1.3.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.4.tar.xz"
#}
#depend{
#	"libogg"
#	"nsam"
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

#touch logs/0030-flac.log
tar -xf src/flac-1.3.4.tar.xz
cd flac-1.3.4


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


#ninja test -j32 | tee ../../logs/0030-flac.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf flac-1.3.4
