#!/bin/bash
#name="libarchive"
#version"3.6.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libarchive/libarchive/releases/download/v3.6.0/libarchive-3.6.0.tar.xz"
#
#}
#depend{
#	"libxml2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0085-libarchive.log
tar -xf src/libarchive-3.6.0.tar.xz
cd libarchive-3.6.0


sed -i '436a if ((OSSL_PROVIDER_load(NULL, "legacy")) == NULL) \
      return (ARCHIVE_FAILED);' libarchive/archive_digest.c
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static

make -j24



LC_ALL=C make check  | tee ../../logs/0085-libarchive.log


make install


cd ../../
rm -rf libarchive-3.6.0
