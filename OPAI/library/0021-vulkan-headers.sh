#!/bin/bash
#name="vulkan-headers"
#version="1.3.208"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O Vulkan-Headers-1.3.208.tar.gz https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v1.3.208.tar.gz"
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


#touch logs/0019-jasper.log
tar -xf src/Vulkan-Headers-1.3.208.tar.gz
cd Vulkan-Headers-1.3.208


mkdir bld
cd bld

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#ninja test | tee ../../logs/0019-jasper.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf Vulkan-Headers-1.3.208
