#!/bin/bash
#name="isocodes"
#version="4.9.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"http://ftp.debian.org/debian/pool/main/i/iso-codes//iso-codes_4.9.0.orig.tar.xz"
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
tar -xf src/iso-codes_4.9.0.orig.tar.xz
cd iso-codes-4.9.0


autoreconf -fi
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

sed -i '/^LN_S/s/s/sfvn/' */Makefile
make install


cd ../../
rm -rf iso-codes-4.9.0
