#!/bin/bash
#name="pcre"
#version"8.45"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.bz2"
#
#}
#depend{
#	"readline"
#	"zlib"
#	"bzip2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0032-pcre.log
tar -xf src/pcre-8.45.tar.bz2
cd pcre-8.45


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-unicode-properties		\
	--enable-pcre16				\
	--enable-pcre32				\
	--enable-pcregrep-libz			\
	--enable-pcregrep-libbz2		\
	--enable-pcretest-libreadline		\
	--disable-static


make -j24


make check -j24 | tee ../../logs/0032-pcre.log


make install -j24


cd ../../
rm -rf pcre-8.45
