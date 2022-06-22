#!/bin/bash
#name="jasper"
#version="3.0.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/jasper-software/jasper/releases/download/version-3.0.3/jasper-3.0.3.tar.gz"
#}
#depend{
#	"cmake"
#	"libjpeg-turbo"
#	"freeglut"
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


touch logs/0019-jasper.log
tar -xf src/jasper-3.0.3.tar.gz
cd jasper-3.0.3


mkdir bld
cd bld

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-DCMAKE_SKIP_INSTALL_RPATH=YES		\
	-DJAS_ENABLE_DOC=NO			\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


ninja test | tee ../../logs/0019-jasper.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf jasper-3.0.3
