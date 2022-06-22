#!/bin/bash
#name="js78"
#version"78.15.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mozilla.org/pub/firefox/releases/78.15.0esr/source/firefox-78.15.0esr.source.tar.xz"
#	"https://www.linuxfromscratch.org/patches/blfs/11.1/js-78.15.0-python_3_10-1.patch"
#}
#depend{
#	"autoconf2.13"
#	"ICU"
#	"rustc"
#	"which"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/firefox-78.15.0esr.source.tar.xz
cd firefox-78.15.0

patch -Np1 -i ../src/js-78.15.0-python_3_10-1.patch

mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
../js/src/configure			\
	--prefix=/usr			\
	--with-intl-api			\
	--with-system-zlib		\
	--with-system-icu		\
	--disable-jemalloc		\
	--disable-debug-symbols		\
	--enable-readline			\
	--target=x86_64-unknown-linux-musl	\
	--host=x86_64-unknown-linux-musl


make -j32


#make check -j32 | tee ../logs/0128-fontconfig.log


make install
rm -v /usr/lib/libjs_static.ajs
sed -i '/@NSPR_CFLAGS@/d' /usr/bin/js78-config


cd ../../
rm -rf firefox-78.15.0
