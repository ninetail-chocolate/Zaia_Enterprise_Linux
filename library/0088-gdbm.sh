#!/bin/bash
#name="gdbm"
#version="1.23"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/gdbm/gdbm-1.23.tar.gz"
#}
#depend{
#	"curl"
#	"pcre"
#	"pcre2"
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
tar -xf src/gdbm-1.23.tar.gz
cd gdbm-1.23


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--disable-static			\
	--enable-shared				\
	--enable-libgdbm-compat


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf gdbm-1.23
