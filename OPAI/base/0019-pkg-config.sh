#!/bin/bash
#name="pkg-config"
#version"0.29.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0019-pkg-config.log
tar -xf src/pkg-config-0.29.2.tar.gz
cd pkg-config-0.29.2



mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--with-internal-glib				\
	--disable-host-tools				\
	--docdir=/usr/share/doc/pkg-config


make -j24


make check -j24 | tee ../../logs/0019-pkg-config.log


make install -j24
rm -rvf /usr/bin/x86_64-zel-linux-musl-pkg-config

cd ../../
rm -rf pkg-config-0.29.2
