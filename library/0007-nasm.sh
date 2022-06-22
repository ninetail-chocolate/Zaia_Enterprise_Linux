#!/bin/bash
#name="nasm"
#version="2.15.05"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.xz"
#}
#depend{
#	"musl"
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


#touch logs/0005-xmlto.log
tar -xf src/nasm-2.15.05.tar.xz
cd nasm-2.15.05


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static

make -j32


#make check -j32 | tee ../../logs/0005-xmlto.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf nasm-2.15.05
