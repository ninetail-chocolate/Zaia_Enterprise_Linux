#!/bin/bash
#name="libaio"
#version"0.3."
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.debian.org/debian/pool/main/liba/libaio/libaio_0.3.112.orig.tar.xz"
#}
#depend{
#	"gnu-efi"
#	"efibootmgr"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"



ln -svf clang /usr/bin/gcc
ln -svf clang++ /usr/bin/g++
tar -xf src/libaio_0.3.112.orig.tar.xz
cd libaio-0.3.112


sed -i '/install.*libaio.a/s/^/#/' src/Makefile
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
make


make install



rm -rf /usr/bin/gcc
rm -rf /usr/bin/g++


cd ../
rm -rf libaio-0.3.112
