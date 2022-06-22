#!/bin/bash
#name="libassuan"
#version="2.5.5"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2"
#}
#depend{
#	"libgpg-error"
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
tar -xf src/libassuan-2.5.5.tar.bz2
cd libassuan-2.5.5


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib=libc++ -rtlib=compiler-rt -unwindlib=libunwind -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libassuan-2.5.5
