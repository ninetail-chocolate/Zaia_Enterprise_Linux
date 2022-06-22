#!/bin/bash
#name="libjpeg-turbo"
#version="2.1.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/libjpeg-turbo/files/2.1.3/libjpeg-turbo-2.1.3.tar.gz"
#}
#depend{
#	"nasm"
#	"yasm"
#	"cmake"
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


touch logs/0009-libjpeg-turbo.log
tar -xf src/libjpeg-turbo-2.1.3.tar.gz
cd libjpeg-turbo-2.1.3


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-DENABLE_STATIC=FALSE			\
	-DCMAKE_INSTALL_DEFAULT_LIBDIR=lib	\
	-DWITH_JPEG8=ON				\
	-DWITH_12BIT=ON				\
	-G Ninja				\
	../

ninja


ninja test | tee ../../logs/0009-libjpeg-turbo.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf libjpeg-turbo-2.1.3
