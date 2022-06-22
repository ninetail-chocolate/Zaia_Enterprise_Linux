#!/bin/bash
#name="libqalculate"
#version="4.1.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/Qalculate/libqalculate/releases/download/v4.1.0/libqalculate-4.1.0.tar.gz"
#}
#depend{
#	"libsassc"
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
tar -xf src/libqalculate-4.1.0.tar.gz
cd libqalculate-4.1.0


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libqalculate-4.1.0
