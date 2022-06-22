#!/bin/bash
#name="Noto-Sans-Runic"
#version"20220222"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://fonts.google.com/download?family=Noto%20Sans%20Runic"
#}
#depend{
#	"not"
#}
#tunebuild="no"
#testhave="no"
#toolchain="no"

mkdir Noto-Sans-Runic
cd Noto-Sans-Runic
unzip ../src/Noto_Sans_Runic.zip


install -Dm644 NotoSansRunic-Regular.ttf -t /usr/share/fonts/Noto-Sans-Runic


fc-cache


cd ../
rm -rvf Noto-Sans-Runic
