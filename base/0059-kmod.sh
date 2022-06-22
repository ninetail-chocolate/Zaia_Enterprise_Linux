#!/bin/bash
#name="kmod"
#version"29"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod/kmod-29.tar.xz"
#
#}
#depend{
#	"openssl"
#	"zlib"
#	"zstd"
#	"xz"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0058-intltool.log
tar -xf src/kmod-29.tar.xz
cd kmod-29


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
	--enable-shared				\
	--disable-static			\
	--with-openssl				\
	--with-xz				\
	--with-zstd				\
	--with-zlib


make -j24


#make check -j1 | tee ../../logs/0058-intltool.log


make install -j24
for target in depmod insmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /usr/sbin/$target
done
ln -sfv kmod /usr/bin/lsmod


cd ../../
rm -rf kmod-29
