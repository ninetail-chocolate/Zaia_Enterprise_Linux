#!/bin/bash
#name="libgcrypt"
#version="1.9.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.9.4.tar.bz2"
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


source /etc/profile

touch logs/0023-libgcrypt.log
tar -xf src/libgcrypt-1.9.4.tar.bz2
cd libgcrypt-1.9.4


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


make check -j32 | tee ../../logs/0022-libgpg-error.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libgcrypt-1.9.4
