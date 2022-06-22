#!/bin/bash
#name="qca"
#version="2.3.4"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.kde.org/stable/qca/2.3.4/qca-2.3.4.tar.xz"
#}
#depend{
#	"cmake"
#	"make-ca"
#	"Qt5"
#	"which"
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
tar -xf src/qca-2.3.4.tar.xz
cd qca-2.3.4


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
rm -rf qca-2.3.4
