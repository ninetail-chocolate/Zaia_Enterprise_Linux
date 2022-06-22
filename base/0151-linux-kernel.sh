#!/bin/bash
#name="btrfs-progs"
#version"5.16"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O zen-kernel-5.16.11-zen1.tar.gz https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v5.16.11-zen1.tar.gz"
#
#}
#depend{
#	"llvm-projects"
#	"cpio"
#	"dracut"
#	"grub"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0144-lzo.log
tar -xf src/zen-kernel-5.16.11-zen1.tar.gz
cd zen-kernel-5.16.11-zen1


make LLVM=1 mrproper


cp ../src/ZEL-AmazingCaucasus-OpenRC-0.50.config .config


make LLVM=1 -j32


make modules_install -j32
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-5.16.11-zen1-ZEL-AmazingCaucasus-OpenRC-0.50
cp -iv System.map /boot/System.map-5.16.11-zen1-ZEL-AmazingCaucasus-OpenRC-0.50
cp -iv .config /boot/config-5.16.11-zen1-ZEL-AmazingCaucasus-OpenRC-0.50
dracut --kver 5.16.11-zen1-ZEL-AmazingCaucasus-OpenRC-0.50





cd ../
rm -rf zen-kernel-5.16.11-zen1
