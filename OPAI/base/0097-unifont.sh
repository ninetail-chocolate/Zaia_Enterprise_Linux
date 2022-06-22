#!/bin/bash
#name="unifont"
#version"13.0.06"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://unifoundry.com/pub/unifont/unifont-13.0.06/font-builds/unifont-13.0.06.pcf.gz"
#}
#depend{
#	"efibootmgr"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


mkdir -pv /usr/share/fonts/unifont
gunzip -v -c src/unifont-13.0.06.pcf.gz > /usr/share/fonts/unifont/unifont.pcf
