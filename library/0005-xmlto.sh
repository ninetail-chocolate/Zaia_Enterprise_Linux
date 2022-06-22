#!/bin/bash
#name="xmlto"
#version="0.0.28"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://releases.pagure.org/xmlto/xmlto-0.0.28.tar.bz2"
#}
#depend{
#	"musl"
#	"libxslt"
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


touch logs/0005-xmlto.log
tar -xf src/xmlto-0.0.28.tar.bz2
cd xmlto-0.0.28


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static

make -j32


make check -j32 | tee ../../logs/0005-xmlto.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf xmlto-0.0.28
