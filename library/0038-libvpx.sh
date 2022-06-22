#!/bin/bash
#name="libvpx"
#version="1.11.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O libvpx-1.11.0.tar.gz https://github.com/webmproject/libvpx/archive/refs/tags/v1.11.0.tar.gz"
#}
#depend{
#	"yasm"
#	"nasm"
#	"which"
#	"curl"
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

#touch logs/0038-libvpx.log
tar -xf src/libvpx-1.11.0.tar.gz
cd libvpx-1.11.0


sed -i 's/cp -p/cp/' build/make/Makefile 
mkdir bld
cd bld


CC=clang					\
CXX=clang++					\
../configure					\
	--extra-cflags="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
	--extra-cxxflags="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
	--prefix=/usr				\
	--disable-static			\
	--enable-shared

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libvpx-1.11.0
