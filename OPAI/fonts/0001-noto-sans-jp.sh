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

mkdir Noto-Sans-JP
cd Noto-Sans-JP
unzip ../src/Noto_Sans_JP.zip


install -Dm644 NotoSansJP*.otf -t /usr/share/fonts/noto-cjk

fc-cache


cd ../
rm -rvf Noto-Sans-JP
