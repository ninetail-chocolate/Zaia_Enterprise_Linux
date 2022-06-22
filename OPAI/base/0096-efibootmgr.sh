#!/bin/bash
#name="efibootmgr"
#version"38"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/rhboot/efibootmgr/archive/17/efibootmgr-17.tar.gz"
#}
#depend{
#	"efivar"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0006-zstd.log
tar -xf src/efibootmgr-17.tar.gz
cd efibootmgr-17

sed -e '/extern int efi_set_verbose/d' -i src/efibootmgr.c
CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -I/usr/include/efivar"	\
make EFIDIR=ZEL EFI_LOADER=grubx64.efi -j12


#make check -j24 | tee ../logs/0006-zstd.log


make install EFIDIR=ZEL


cd ../
rm -rf efibootmgr-17
