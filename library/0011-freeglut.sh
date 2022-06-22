#!/bin/bash
#name="freeglut"
#version="3.2.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/freeglut/files/freeglut/3.2.2/freeglut-3.2.2.tar.gz"
#}
#depend{
#	"cmake"
#	"ninja"
#	"mesa"
#	"glu"
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


#touch logs/0011-freeglut.log
tar -xf src/freeglut-3.2.2.tar.gz
cd freeglut-3.2.2


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-DFREEGLUT_BUILD_DEMOS=OFF		\
	-DFREEGLUT_BUILD_STATIC_LIBS=OFF	\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#ninja test | tee ../../logs/0011-freeglut.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf freeglut-3.2.2
