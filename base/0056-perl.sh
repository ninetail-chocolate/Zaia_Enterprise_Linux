#!/bin/bash
#name="perl"
#version"5.35.9"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.cpan.org/src/5.0/perl-5.35.9.tar.xz"
#
#}
#depend{
#	"groff"
#	"zlib"
#	"bzip2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0056-perl.log
tar -xf src/perl-5.35.9.tar.xz
cd perl-5.35.9


export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure						\
	-des						\
	-Dcc=clang					\
	-Dccflags="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl"		\
	-Dprefix=/usr					\
	-Dvendorprefix=/usr				\
	-Dprivlib=/usr/lib/perl5/5.35.9/core_perl		\
	-Darchlib=/usr/lib/perl5/5.35.9/core_perl		\
	-Dsitelib=/usr/lib/perl5/5.35.9/site_perl		\
	-Dsitearch=/usr/lib/perl5/5.35.9/site_perl	\
	-Dvendorlib=/usr/lib/perl5/5.35.9/vendor_perl	\
	-Dvendorarch=/usr/lib/perl5/5.35.9/vendor_perl	\
	-Dpager="/usr/bin/less -isR"			\
	-Duseshrplib					\
	-Dusethreads					\
	-Dusedevel



make -j24


make test -j24 | tee ../logs/0056-perl.log


make install -j24
###temp fix
rm -rvf /usr/bin/perl
ln -svf perl5.35.9 /usr/bin/perl


unset BUILD_ZLIB BUILD_BZIP2
cd ../
rm -rf perl-5.35.9
