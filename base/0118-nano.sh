#!/bin/bash
#name="nano"
#version"6.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.nano-editor.org/dist/v6/nano-6.2.tar.xz"
#}
#depend{
#	"musl"
#	"ncurses"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/nano-6.2.tar.xz
cd nano-6.2


mkdir build
cd build

../configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--enable-nls			\
	--enable-utf8


make -j32


#make check -j32 | tee ../../logs/0118-nano.log


make install


cd ../../
rm -rf nano-6.2
