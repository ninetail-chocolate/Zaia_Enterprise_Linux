#!/bin/bash
#name="libgcrypt"
#version="0.15.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libass/libass/releases/download/0.15.2/libass-0.15.2.tar.xz"
#}
#depend{
#	"freetype"
#	"fribidi"
#	"nasm"
#	"fontconfig"
#	"harfbuzz"
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

#touch logs/0023-libgcrypt.log
tar -xf src/libass-0.15.2.tar.xz
cd libass-0.15.2


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


#make check -j32 | tee ../../logs/0022-libgpg-error.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libass-0.15.2
