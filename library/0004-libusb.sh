#!/bin/bash
#name="libusb"
#version="1.0.25"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libusb/libusb/releases/download/v1.0.25/libusb-1.0.25.tar.bz2"
#}
#depend{
#	"eudev"
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


#touch logs/0003-gnutls.log
tar -xf src/libusb-1.0.25.tar.bz2
cd libusb-1.0.25


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static

make -j32


#make check -j32 | tee ../../logs/0003-gnutls.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf libusb-1.0.25
