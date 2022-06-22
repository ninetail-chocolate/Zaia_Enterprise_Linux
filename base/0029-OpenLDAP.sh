#!/bin/bash
#name="OpenLDAP"
#version"2.6.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.1.tgz"
#
#}
#depend{
#	"rpcsvc-proto"
#	"lintirpc"
#	"libtool-GNU"
#	"Cyrus-SASL"
#	"groff"
#	"openSSL"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0030-OpenLDAP.log
tar -xf src/openldap-2.6.1.tgz
cd openldap-2.6.1


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--sysconfdir=/etc				\
	--localstatedir=/var				\
	--libexecdir=/usr/lib				\
	--disable-static				\
	--enable-versioning=yes				\
	--disable-debug					\
	--with-tls=openssl				\
	--with-cyrus-sasl				\
	--enable-dynamic				\
	--enable-crypt					\
	--enable-spasswd				\
	--enable-slapd					\
	--enable-modules				\
	--enable-rlookups				\
	--enable-backends=mod				\
	--disable-ndb					\
	--disable-sql					\
	--disable-wt					\
	--enable-overlays=mod

make depend -j24
make -j24


#make test -j24 | tee ../../logs/0030-OpenLDAP.log


make install -j24
sed -e "s/\.la/.so/" -i /etc/openldap/slapd.{conf,ldif}{,.default}
install -v -dm700 -o ldap -g ldap /var/lib/openldap
install -v -dm700 -o ldap -g ldap /etc/openldap/slapd.d
chmod   -v    640     /etc/openldap/slapd.{conf,ldif}
chown   -v  root:ldap /etc/openldap/slapd.{conf,ldif} 


cd ../../
rm -rf openldap-2.6.1
