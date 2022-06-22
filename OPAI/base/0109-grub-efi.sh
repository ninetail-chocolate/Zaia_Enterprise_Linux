#!/bin/bash
#name="GRUB-EFI"
#version"2.06"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O openrc-0.44.10.tar.gz  https://github.com/OpenRC/openrc/archive/refs/tags/0.44.10.tar.gz"
#}
#depend{
#	"musl"
#	"eudev"
#}
#commnet{
#	"DONT USE fPIC flag!!!!!"
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/grub-2.06.tar.xz
cd grub-2.06

mkdir bld
cd bld

../configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe"			\
CXXFLAGS="-march=znver1 -O2 -pipe"			\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--disable-efiemu			\
	--with-platform=efi			\
	--target=x86_64	


make -j32


make install
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

cd ../../
rm -rf grub-2.06
