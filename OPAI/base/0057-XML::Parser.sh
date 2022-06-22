#!/bin/bash
#name="XML::Parser"
#version"2.46"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz"
#
#}
#depend{
#	"perl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0057-XML::Parser.log
tar -xf src/XML-Parser-2.46.tar.gz
cd XML-Parser-2.46


perl5.35.9 Makefile.PL


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make -j24


make test -j24 | tee ../logs/0057-XML::Parser.log


make install


cd ../
rm -rf XML-Parser-2.46
