#!/bin/bash
#name="btrfs-progs"
#version"5.16"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://mirrors.edge.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v5.16.tar.xz"
#
#}
#depend{
#	"lzo"
#	"zstd"
#	"zlib"
#	"pcre"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0144-lzo.log
tar -xf src/btrfs-progs-v5.16.tar.xz
cd btrfs-progs-v5.16


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
./configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--bindir=/usr/bin			\
	--sbindir=/usr/sbin			\
	--sysconfdir=/etc			\
	--localstatedir=/var			\
	--enable-shared				\
	--disable-static			\
	--disable-documentation			\
	--disable-backtrace


make -j32


#make -j32 check | tee ../../logs/0144-lzo.log


make install -j24


cd ../
rm -rf btrfs-progs-v5.16
