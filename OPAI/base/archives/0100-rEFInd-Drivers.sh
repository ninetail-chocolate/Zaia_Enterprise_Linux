#!/bin/bash
#name="rEFInd-Drives"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/refind/files/0.13.2/refind-bin-gnuefi-0.13.2.zip"
#}
#depend{
#	"gnu-efi"
#	"efibootmgr"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0006-zstd.log
unzip src/refind-bin-gnuefi-0.13.2.zip
cd refind-bin-0.13.2


install -vDm 644 refind/drivers_x64/*.efi -t /usr/share/refind/drivers_x64



#make PREFIX=/usr INSTALLROOT=/ install


cd ../
rm -rf refind-bin-0.13.2
