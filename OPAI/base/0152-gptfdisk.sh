#!/bin/bash
#name="gptfdisk"
#version"1.0.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/gptfdisk/files/gptfdisk/1.0.8/gptfdisk-1.0.8.tar.gz"
#	"https://git.alpinelinux.org/aports/plain/main/gptfdisk/fix-wrong-include.patch"
#}
#depend{
#	"popt"
#	"ncurses"
#	"util-linux"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0144-lzo.log
tar -xf src/gptfdisk-1.0.8.tar.gz
cd gptfdisk-1.0.8


patch -Np1 -i ../src/fix-wrong-include.patch


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make -j32


#make -j32 check | tee ../../logs/0144-lzo.log


install -vDm755 gdisk /usr/sbin/
install -vDm755 cgdisk /usr/sbin/
install -vDm755 sgdisk /usr/sbin/
install -vDm755 fixparts /usr/sbin/


cd ../
rm -rf gptfdisk-1.0.8
