#!/bin/bash
#name="efivar"
#version"38"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/rhboot/efivar/releases/download/37/efivar-37.tar.bz2"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0006-zstd.log
tar -xf src/efivar-37.tar.bz2
cd efivar-37


CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC --stdlib=libc++ -rtlib=compiler-rt -unwindlib="libunwind" --target=x86_64-zel-linux-musl -fuse-ld=lld"	\
make -j12


#make check -j24 | tee ../logs/0006-zstd.log


make LIBDIR=/usr/lib install


cd ../
rm -rf efivar-37
