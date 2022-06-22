#!/bin/bash
#name="acl"
#version"2.5.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://download.savannah.nongnu.org/releases/acl/acl-2.3.1.tar.xz"
#}
#depend{
#	"attr"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0014-attr.log
tar -xf src/acl-2.3.1.tar.xz
cd acl-2.3.1


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
	--disable-static			\
	--sysconfdir=/etc

time make -j24


#time make check -j24 | tee ../../logs/0015-acl.log


time make install


cd ../../
rm -rf acl-2.3.1
