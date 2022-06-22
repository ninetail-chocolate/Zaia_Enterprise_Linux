#!/bin/bash
#name="make-ca"
#version"1.10"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/lfs-book/make-ca/releases/download/v1.10/make-ca-1.10.tar.xz"
#}
#depend{
#	"p11-kit"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0013-libffi.log
tar -xf src/make-ca-1.10.tar.xz
cd make-ca-1.10


make install_bin
install -vdm755 /etc/ssl/local


cd ../
rm -rf make-ca-1.10


#####################################
/usr/sbin/make-ca -g
####################################
