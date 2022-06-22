#!/bin/bash
#name="xinit"
#version="1.4.1"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/app/xinit-1.4.1.tar.bz2"
#   }
#depend{
#	"xwud"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/xinit-1.4.1.tar.bz2
cd xinit-1.4.1


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG


make


make install


cd ../
rm -rf xinit-1.4.1
