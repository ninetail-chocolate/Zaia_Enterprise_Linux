#!/bin/bash
#name="xcursor-themes"
#version="1.0.6"
#zel-version="1"
#src{
#	"https://www.x.org/pub/individual/data/xcursor-themes-1.0.6.tar.bz2"
#   }
#depend{
#	"xwud"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/xcursor-themes-1.0.6.tar.bz2
cd xcursor-themes-1.0.6


./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG


make


make install


cd ../
rm -rf xcursor-themes-1.0.6
