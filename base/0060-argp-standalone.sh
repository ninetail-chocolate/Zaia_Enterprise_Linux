#!/bin/bash
#name="argp-standalone"
#version"1.4.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O argp-standalone-1.4.1.tar.gz https://github.com/ericonr/argp-standalone/archive/refs/tags/1.4.1.tar.gz"
#
#}
#depend{
#	"openssl"
#	"zlib"
#	"zstd"
#	"xz"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0058-intltool.log
tar -xf src/argp-standalone-1.4.1.tar.gz
cd argp-standalone-1.4.1


autoreconf -vif

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
./configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--localstatedir=/var			\
	--enable-shared				\
	--disable-static			\


make -j24

#mkdir -pv /usr/base/oppai/DT
#make DESTDIR=/usr/base/oppai/DT install
#make check -j1 | tee ../../logs/0058-intltool.log


#make install -j24
install -D -m644 argp.h /usr/include/argp.h
install -D -m755 libargp.a /usr/lib/libargp.a


cd ../
rm -rf argp-standalone-1.4.1
