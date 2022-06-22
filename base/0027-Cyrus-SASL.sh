#!/bin/bash
#name="Cyrus-SASL-minimal"
#version"2.1.28"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.28/cyrus-sasl-2.1.28.tar.gz"
#
#}
#depend{
#	"krb5-minimal"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0027-OpenSSL.log
tar -xf src/cyrus-sasl-2.1.28.tar.gz
cd cyrus-sasl-2.1.28


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--enable-auth-sasldb			\
	--with-dbpath=/var/lib/sasl/sasldb2	\
	--with-sphinx-build=no			\
	--with-saslauthd=/var/run/saslauthd


make -j1


#make test -j24 | tee ../../logs/0027-OpenSSL.log


make install -j1
install -v -dm700 /var/lib/sasl



cd ../../
rm -rf cyrus-sasl-2.1.28
