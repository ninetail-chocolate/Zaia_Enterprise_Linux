#!/bin/bash
#name="audit"
#version"3.0.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://people.redhat.com/sgrubb/audit/audit-3.0.7.tar.gz"
#
#}
#depend{
#	"libcap"
#	"krb5"or"krb5-minimal"
#	"swig"
#	"libcap-ng"
#	"OpenLDAP"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/audit-3.0.7.tar.gz
cd audit-3.0.7


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--disable-static				\
	--prefix=/usr					\
	--sysconfdir=/etc				\
	--libexecdir=/usr/lib/audit			\
	--enable-gssapi-krb5=yes			\
	--with-libcap-ng=yes


make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24


cd ../../
rm -rf audit-3.0.7
