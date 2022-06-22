#!/bin/bash
#name="mcstrans"
#version"3.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/SELinuxProject/selinux/releases/download/3.3/mcstrans-3.3.tar.gz"
#
#}
#depend{
#	"libcap-PAM"
#	"libselinux"
#	"pcre"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/mcstrans-3.3.tar.gz
cd mcstrans-3.3


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make SBINDIR=/usr/bin install -j24


cd ../
rm -rf mcstrans-3.3
