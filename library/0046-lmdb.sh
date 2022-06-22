#!/bin/bash
#name="lmdb"
#version="0.9.29"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/LMDB/lmdb/archive/LMDB_0.9.29.tar.gz"
#}
#depend{
#	"musl"
#	"make"
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

#touch logs/0045-libical.log
tar -xf src/LMDB_0.9.29.tar.gz
cd lmdb-LMDB_0.9.29


cd libraries/liblmdb

make -j32					\
CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"

sed -i 's| liblmdb.a||' Makefile


#ninja -j1


#ninja test -j32 | tee ../../logs/0045-libical.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make prefix=/usr install


cd ../../../
rm -rf lmdb-LMDB_0.9.29
