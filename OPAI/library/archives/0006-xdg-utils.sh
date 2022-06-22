#!/bin/bash
#name="xdg-utils"
#version="1.1.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://portland.freedesktop.org/download/xdg-utils-1.1.3.tar.gz"
#}
#depend{
#	"xmlto"
#	"links"
#	"dbus"
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


touch logs/0006-xdg-utils.log
tar -xf src/xdg-utils-1.1.3.tar.gz
cd xdg-utils-1.1.3



CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure						\
	--prefix=/usr					\
	--mandir=/usr/share/man
make -j32


#make check -j32 | tee ../logs/0006-xdg-utils.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
#make install


cd ../
rm -rf xdg-utils-1.1.3
