#!/bin/bash
#name="openjpeg"
#version="2.4.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O openjpeg-2.4.0.tar.gz https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.4.0.tar.gz"
#}
#depend{
#	"cmake"
#	"lcms2"
#	"libpng"
#	"libtiff"
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

#touch logs/0019-jasper.log
tar -xf src/openjpeg-2.4.0.tar.gz
cd openjpeg-2.4.0


mkdir bld
cd bld

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-DBUILD_STATIC_LIBS=OFF			\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#ninja test | tee ../../logs/0019-jasper.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf openjpeg-2.4.0
