#!/bin/bash
#name="libelf"
#version"0.186"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceware.org/elfutils/ftp/0.186/elfutils-0.186.tar.bz2"
#	"https://git.alpinelinux.org/aports/plain/main/elfutils/musl-strndupa.patch"
#	"https://git.alpinelinux.org/aports/plain/main/elfutils/error.h"
#
#}
#depend{
#	"musl-fts"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0060-libelf.log
tar -xf src/elfutils-0.186.tar.bz2
cd elfutils-0.186
patch -Np1 -i ../src/musl-strndupa.patch
cp ../src/error.h ./lib
cp ../src/error.h ./src



CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
./configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--disable-werror			\
	--disable-debuginfod			\
	--enable-libdebuginfod=dummy

make -j24

echo "########################"
#make check -j1 | tee ../../logs/0060-libelf.log


#mkdir /usr/oppai/base/DT
#make DESTDIR=/usr/oppai/base/DT  -C libelf install 
make -C libelf install -j24
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm -rvf /usr/lib/libelf.a


cd ../
rm -rf elfutils-0.186
