#!/bin/bash
#name="harfbuzz"
#version"3.4.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/harfbuzz/harfbuzz/releases/download/3.4.0/harfbuzz-3.4.0.tar.xz"
#
#}
#depend{
#	"freetype2"
#	"graphite2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0090-harfbuzz.log
tar -xf src/harfbuzz-3.4.0.tar.xz
cd harfbuzz-3.4.0


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
meson							\
	--prefix=/usr					\
	--buildtype=release				\
	-Dgraphite2=enabled				\
	-Dgraphite2=enabled
../


ninja


ninja test | tee ../../logs/0090-harfbuzz.log


ninja install


cd ../../
rm -rf harfbuzz-3.4.0
