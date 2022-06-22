#!/bin/bash
#name="sed"
#version"4.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/sed/sed-4.8.tar.xz"
#
#}
#depend{
#	"libcap"
#	"krb5"or"krb5-minimal"
#	"swig"
#	"libcap-ng"
#	"OpenLDAP"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0039-sed.log
tar -xf src/sed-4.8.tar.xz
cd sed-4.8


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--without-selinux				\
	--prefix=/usr

make -j24 


make check -j24 | tee ../../logs/0039-sed.log


make install -j24


cd ../../
rm -rf sed-4.8
