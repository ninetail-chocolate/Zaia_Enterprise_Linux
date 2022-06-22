#!/bin/bash
#name="zip"
#version="30"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://downloads.sourceforge.net/infozip/zip30.tar.gz"
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


#touch logs/0038-libvpx.log
tar -xf src/zip30.tar.gz
cd zip30


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
make -f unix/Makefile generic -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST  install


make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile  install


cd ../
rm -rf zip30
