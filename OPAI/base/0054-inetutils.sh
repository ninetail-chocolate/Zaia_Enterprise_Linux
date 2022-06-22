#!/bin/bash
#name="inetutils"
#version"2.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/inetutils/inetutils-2.2.tar.xz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0054-inetutils.log
tar -xf src/inetutils-2.2.tar.xz
cd inetutils-2.2


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--localstatedir=/var			\
	--disable-logger			\
	--disable-whois				\
	--disable-rcp				\
	--disable-rexec				\
	--disable-rlogin			\
	--disable-rsh				\
	--disable-servers


make -j24


make check -j1 | tee ../../logs/0054-inetutils.log


make install -j24
mv -v /usr/{,s}bin/ifconfig


cd ../../
rm -rf inetutils-2.2
