#!/bin/bash
#name="json-c"
#version="0.15"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://s3.amazonaws.com/json-c_releases/releases/json-c-0.15.tar.gz"
#}
#depend{
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


#touch logs/0038-libvpx.log
tar -xf src/json-c-0.15.tar.gz
cd json-c-0.15


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
	-DBUILD_STATIC_LIBS="OFF"		\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install


cd ../../
rm -rf json-c-0.15
