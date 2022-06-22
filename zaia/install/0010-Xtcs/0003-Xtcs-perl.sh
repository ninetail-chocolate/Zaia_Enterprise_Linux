#!/bin/bash
#name="Xtcs-perl"
#version"5.34.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.cpan.org/src/5.0/perl-5.34.1.tar.gz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/perl-5.34.1.tar.gz
cd perl-5.34.1


sh Configure						\
	-des						\
	-Dcc=clang					\
	-Dccflags="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
	-Dprefix=/usr					\
	-Dvendorprefix=/usr				\
	-Dprivlib=/usr/lib/perl5/5.34/core_perl		\
	-Darchlib=/usr/lib/perl5/5.34/core_perl		\
	-Dsitelib=/usr/lib/perl5/5.34/site_perl		\
	-Dsitearch=/usr/lib/perl5/5.34/site_perl		\
	-Dvendorlib=/usr/lib/perl5/5.34/vendor_perl		\
	-Dvendorarch=/usr/lib/perl5/5.34/vendor_perl		\
	-Dman1dir=/usr/share/man/man1				\
	-Dman3dir=/usr/share/man/man3

make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../
rm -rf perl-5.34.1
