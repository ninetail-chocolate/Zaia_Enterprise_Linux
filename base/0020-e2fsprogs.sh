#!/bin/bash
#name="e2fsprogs"
#version"1.46.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.46.5/e2fsprogs-1.46.5.tar.xz"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0020-e2fsprogs.log
tar -xf src/e2fsprogs-1.46.5.tar.xz
cd e2fsprogs-1.46.5


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
	--sysconfdir=/etc				\
	--enable-elf-shlibs				\
	--disable-libblkid				\
	--disable-libuuidd				\
	--disable-uuidd					\
	--disable-fsck


make -j24


make check -j24 | tee ../../logs/0020-e2fsprogs.log


make install -j24
rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a


cd ../../
rm -rf e2fsprogs-1.46.5
