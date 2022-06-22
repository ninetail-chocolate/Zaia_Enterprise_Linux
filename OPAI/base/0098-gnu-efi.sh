#!/bin/bash
#name="gnu-efi"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/gnu-efi/files/gnu-efi-3.0.14.tar.bz2"
#}
#depend{
#	"efivar"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


ln -svf clang /usr/bin/gcc
ln -svf clang++ /usr/bin/g++

touch logs/0006-zstd.log
tar -xf src/gnu-efi-3.0.14.tar.bz2
cd gnu-efi-3.0.14


sed -i 's/-maccumulate-outgoing-args//g' Make.defaults
CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"	\
make -j1


make  PREFIX=/usr INSTALLROOT=/ install


rm -rf /usr/bin/gcc
rm -rf /usr/bin/g++

cd ../
rm -rf gnu-efi-3.0.14
