#!/bin/bash
#name="iana-etc"
#version"20220222"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/Mic92/iana-etc/releases/download/20220222/iana-etc-20220222.tar.gz"
#}
#depend{
#	"not"
#}
#tunebuild="no"
#testhave="no"
#toolchain="no"

tar -xf src/iana-etc-20220222.tar.gz
cd iana-etc-20220222

cp -rvf   services protocols /etc


cd ../
rm -rvf iana-etc-20220222
