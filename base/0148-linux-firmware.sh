#!/bin/bash
#name="linux-firmware"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-20220209.tar.gz"
#}
#depend{
#	"gnu-efi"
#	"efibootmgr"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0006-zstd.log
tar -xf src/linux-firmware-20220209.tar.gz
cd linux-firmware-20220209


make FIRMWAREDIR=/usr/lib/firmware install


cd ../
rm -rf linux-firmware-20220209
