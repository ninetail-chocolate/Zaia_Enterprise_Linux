#!/bin/bash
#name="unzip"
#version"6.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.sourceforge.net/infozip/unzip60.tar.gz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0006-zstd.log
tar -xf src/unzip60.tar.gz
cd unzip60


CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make -f unix/Makefile generic -j12


#make check -j24 | tee ../logs/0006-zstd.log


make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install


cd ../
rm -rf unzip60
