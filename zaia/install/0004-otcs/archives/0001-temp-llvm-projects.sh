#!/bin/bash
#name="Xtcs-llvm"
#version"13.0.1"
#zel-version="1"
#comment{
#       WTF!?
#}
#src={
#       "https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/clang+llvm-13.0.1-x86_64->
#depend{
#       "not"
#}
#tunebuild="no"
#testhave="no"   
#toolchain="llvm"
#type="prebuild"

tar -xf src/clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cd clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04

cp -rvf ./* $ZEL/pretools


cd ../    
rm -rf clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04
