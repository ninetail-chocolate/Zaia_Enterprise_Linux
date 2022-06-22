#!/bin/bash
#name="c-ares"
#version="1.17.2"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://c-ares.haxx.se/download/c-ares-1.17.2.tar.gz"
#}
#depend{
#	"cmake"
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


#touch logs/0038-libvpx.log
tar -xf src/c-ares-1.17.2.tar.gz
cd c-ares-1.17.2


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE="Release"		\
	-DBUILD_SHARED_LIBS="ON"		\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install


cd ../../
rm -rf c-ares-1.17.2
