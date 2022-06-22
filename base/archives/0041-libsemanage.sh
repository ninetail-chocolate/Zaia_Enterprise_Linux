#!/bin/bash
#name="libsemanage"
#version"3.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/SELinuxProject/selinux/releases/download/3.3/libsemanage-3.3.tar.gz"
#
#}
#depend{
#	"libsepol"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/libsemanage-3.3.tar.gz
cd libsemanage-3.3


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
PYTHON=python3			\
make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24


cd ../
rm -rf libsemanage-3.3
