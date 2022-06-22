#!/bin/bash
#name="pre-Xtcs-zen-headers"
#version"5.17.1"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"wget -O zen-kernel-5.17.1-zen1.tar.gz https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v5.17.1-zen1.tar.gz"
#}
#depend{
#	"none"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="no"
#testhave="no"
#toolchain="no"
tar -xf src/zen-kernel-5.17.1-zen1.tar.gz
cd zen-kernel-5.17.1-zen1


make LLVM=1 mrproper
make LLVM=1 headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
mkdir -pv $ZEL/usr/include/
cp -rv usr/include/* $ZEL/usr/include/


cd ../
rm -rf zen-kernel-5.17.1-zen1
