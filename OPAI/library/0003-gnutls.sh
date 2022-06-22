#!/bin/bash
#name="gnutls"
#version="3.7.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.3.tar.xz"
#}
#depend{
#	"libunistring"
#	"nettle"
#	"libtasn1"
#	"p11-kit"
#	"make-ca"
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


#touch logs/0003-gnutls.log
tar -xf src/gnutls-3.7.3.tar.xz
cd gnutls-3.7.3


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	--disable-guile					\
	--disable-rpath					\
	--with-default-trust-store-pkcs11="pkcs11:" 

make -j32


#make check -j32 | tee ../../logs/0003-gnutls.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf gnutls-3.7.3
