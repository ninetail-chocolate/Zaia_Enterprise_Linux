#!/bin/bash
#name="bash"
#version"5.2-alpha"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/bash/bash-5.2-alpha.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0050-grep.log
tar -xf src/bash-5.2-alpha.tar.gz
cd bash-5.2-alpha


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--without-bash-malloc			\
	--with-installed-readline


make -j24


#make check| tee ../../logs/0050-grep.log


make install -j24


cd ../../
rm -rf bash-5.2-alpha
