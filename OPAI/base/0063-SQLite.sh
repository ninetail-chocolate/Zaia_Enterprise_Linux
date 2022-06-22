#!/bin/bash
#name="SQLite"
#version"3.38.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.sqlite.org/2022/sqlite-autoconf-3380000.tar.gz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0013-libffi.log
tar -xf src/sqlite-autoconf-3380000.tar.gz
cd sqlite-autoconf-3380000


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CPPFLAGS="-DSQLITE_ENABLE_FTS3=1		\
-DSQLITE_ENABLE_FTS4=1				\
-DSQLITE_ENABLE_COLUMN_METADATA=1		\
-DSQLITE_ENABLE_UNLOCK_NOTIFY=1			\
-DSQLITE_ENABLE_DBSTAT_VTAB=1			\
-DSQLITE_SECURE_DELETE=1			\
-DSQLITE_ENABLE_FTS3_TOKENIZER=1"		\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--disable-static			\
	--enable-shared				\
	--enable-fts5

make


make install


cd ../../
rm -rf sqlite-autoconf-3380000
