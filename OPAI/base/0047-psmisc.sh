#!/bin/bash
#name="psmisc"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.4.tar.xz"
#
#}
#depend{
#	"libselinux"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0036-autoconf.log
tar -xf src/psmisc-23.4.tar.xz
cd psmisc-23.4


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr


make -j24


#make check| tee ../../logs/0036-autoconf.log


make install -j24


cd ../../
rm -rf psmisc-23.4
