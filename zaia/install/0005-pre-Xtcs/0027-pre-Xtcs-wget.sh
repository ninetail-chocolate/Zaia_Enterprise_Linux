#!/bin/bash
#name="wget"
#version"1.21.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/wget/wget-1.21.3.tar.gz"
#}
#depend{
#	"pre-Xtcs-OpenSSL"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/wget-1.21.3.tar.gz
cd wget-1.21.3


mkdir build
cd build

../configure				\
AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl --sysroot=$ZEL -isystem=$ZEL -flto=full"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl --sysroot=$ZEL -isystem=$ZEL -flto=full"		\
	--prefix=/usr			\
	--bindir=/usr/bin		\
	--sbindir=/usr/sbin		\
	--sysconfdir=/etc		\
	--mandir=/usr/share/man		\
	--infodir=/usr/share/info	\
	--localstatedir=/var		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--enable-shared			\
	--disable-static		\
	--with-ssl=openssl		\
	--with-openssl			\
	--without-zlib			\
	--disable-ntlm			\
	--disable-pcre2			\
	--disable-pcre			\
	--disable-debug
	


make -j32


#make check -j32 | tee ../../logs/0121-wget.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make DESTDIR=$ZEL install


cd ../../
rm -rf wget-1.21.3
