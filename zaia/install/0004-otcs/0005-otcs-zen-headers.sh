#!/bin/bash
#name="otcs-zen-headers"
#version"5.17.1"
#zel-version="3"
#comment{
#	WTF!?
#}
#src={
#	"wget -O zen-kernel-5.17.1-zen1.tar.gz https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v5.17.1-zen1.tar.gz"
#}
#depend{
#	"otcs-lld"
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
mkdir -pv $ZEL/tools/include/
cp -rv usr/include/* $ZEL/tools/include/


cd ../
rm -rf zen-kernel-5.17.1-zen1
