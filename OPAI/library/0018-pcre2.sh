#!/bin/bash
#name="pcre2"
#version="10.37"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ja.osdn.net/projects/sfnet_pcre/downloads/pcre2/10.37/pcre2-10.37.tar.bz2"
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


touch logs/0018-pcre2.log
tar -xf src/pcre2-10.37.tar.bz2
cd pcre2-10.37


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--enable-unicode			\
	--enable-jit				\
	--enable-pcre2-16			\
	--enable-pcre2-32			\
	--enable-pcre2grep-libz			\
	--enable-pcre2grep-libbz2		\
	--enable-pcre2test-libreadline

make -j32


make check -j32 | tee ../../logs/0018-pcre2.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf pcre2-10.37
