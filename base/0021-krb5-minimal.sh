#!/bin/bash
#name="krb5-minimal"
#version"1.19.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://kerberos.org/dist/krb5/1.19/krb5-1.19.2.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0021-krb5-minimal.log
tar -xf src/krb5-1.19.2.tar.gz
cd krb5-1.19.2


cd src
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--sysconfdir=/etc				\
	--localstatedir=/var/lib			\
	--runstatedir=/run				\
	--with-system-et				\
	--with-system-ss				\
	--with-system-verto=no				\
	--enable-dns-for-realm


make -j24


#make check -j24 | tee ../../logs/0021-krb5-minimal.log


make install -j24
install -Dpm 644 ../config-files/krb5.conf -t "/etc"
install -Dpm 644 ../config-files/kdc.conf -t "/var/lib/krb5kdc"
install -Dm 644 ../util/ac_check_krb5.m4 -t "/usr/share/aclocal"


cd ../../../
rm -rf krb5-1.19.2
