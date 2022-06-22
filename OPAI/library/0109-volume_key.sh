#!/bin/bash
#name="volume_key"
#version="0.3.12"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/felixonmars/volume_key/archive/volume_key-0.3.12.tar.gz"
#}
#depend{
#	"cryptsetup"
#	"glib"
#	"gpgme"
#	"nss"
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
tar -xf src/volume_key-0.3.12.tar.gz
cd volume_key-volume_key-0.3.12


autoreconf -fiv
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib=libc++ -rtlib=compiler-rt -unwindlib=libunwind -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--without-python			\
	--without-python3

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf volume_key-volume_key-0.3.12
