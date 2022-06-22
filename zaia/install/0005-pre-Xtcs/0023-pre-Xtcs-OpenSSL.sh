#!/bin/bash
#name="OpenSSL"
#version"3.0.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O openssl-openssl-3.0.2.tar.gz https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.2.tar.gz"
#
#}
#depend{
#	"pre-Xtcs-coreutils"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0027-OpenSSL.log
tar -xf src/openssl-openssl-3.0.2.tar.gz
cd openssl-openssl-3.0.2


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl --sysroot=$ZEL -isysroot=$ZEL "			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl --sysroot=$ZEL -isysroot=$ZEL "			\
../config						\
	--prefix=/usr					\
	--openssldir=/etc/ssl				\
	--libdir=lib					\
	shared						\
	no-zlib


make -j24
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile


#make test -j24 | tee ../../logs/0027-OpenSSL.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make DESTDIR=$ZEL install -j24


cd ../../
rm -rf openssl-openssl-3.0.2
