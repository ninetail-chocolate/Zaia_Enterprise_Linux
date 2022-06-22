#!/bin/bash
#name="OpenSSL"
#version"3.0.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O openssl-openssl-3.0.1.tar.gz https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.1.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0027-OpenSSL.log
tar -xf src/openssl-openssl-3.0.1.tar.gz
cd openssl-openssl-3.0.1


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../config						\
	--prefix=/usr					\
	--openssldir=/etc/ssl				\
	--libdir=lib					\
	shared						\
	zlib-dynamic


make -j24


make test -j24 | tee ../../logs/0027-OpenSSL.log


sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make install -j24


cd ../../
rm -rf openssl-openssl-3.0.1
