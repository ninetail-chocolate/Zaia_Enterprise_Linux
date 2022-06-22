#!/bin/bash
#name="Noto-Sans-Mono"
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

mkdir Noto-Sans-Mono
cd Noto-Sans-Mono
unzip ../src/Noto_Sans_Mono.zip


install -Dm644 NotoSansMono-VariableFont_wdth,wght.ttf -t /usr/share/fonts/noto-mono


fc-cache


cd ../
rm -rvf Noto-Sans-Mono
