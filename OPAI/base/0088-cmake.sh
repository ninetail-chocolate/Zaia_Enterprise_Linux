#!/bin/bash
#name="cmake"
#version"3.22.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://cmake.org/files/v3.22/cmake-3.22.3.tar.gz"
#
#}
#depend{
#	"libuv"
#	"curl"
#	"libarchive"
#	"nghttp2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0085-libarchive.log
tar -xf src/cmake-3.22.3.tar.gz
cd cmake-3.22.3


sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake 
mkdir build
cd build


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
../bootstrap						\
	--prefix=/usr					\
	--system-libs					\
	--mandir=/share/man				\
	--no-system-jsoncpp				\
	--no-system-librhash				\
	--parallel=24


make -j24


#make check  | tee ../../logs/0085-libarchive.log


make install


cd ../../
rm -rf cmake-3.22.3
