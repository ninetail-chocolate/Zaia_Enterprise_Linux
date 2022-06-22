#!/bin/bash
#name="chtcs-2nd-perl"
#version="5.35.10"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://www.cpan.org/src/5.0/perl-5.35.10.tar.gz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/perl-5.35.10.tar.gz
cd perl-5.35.10


sh Configure						\
	-des						\
	-Dcc=clang					\
	-Dccflags="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl --sysroot=$ZEL/tools -isystem="$ZEL/tools""		\
	-Dprefix=$ZEL/tools					\
	-Dvendorprefix=$ZEL/tools/usr				\
	-Dprivlib=$ZEL/tools/usr/lib/perl5/5.34/core_perl		\
	-Darchlib=$ZEL/tools/usr/lib/perl5/5.34/core_perl		\
	-Dsitelib=$ZEL/tools/usr/lib/perl5/5.34/site_perl		\
	-Dsitearch=$ZEL/tools/usr/lib/perl5/5.34/site_perl	\
	-Dvendorlib=$ZEL/tools/usr/lib/perl5/5.34/vendor_perl	\
	-Dvendorarch=$ZEL/tools/usr/lib/perl5/5.34/vendor_perl	\
	-Dusedevel


make -j24


#make install


cd ../
#rm -rf perl-5.35.10
