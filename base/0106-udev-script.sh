#!/bin/bash
#name="udev-script"
#version"35"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://gitweb.gentoo.org/proj/udev-gentoo-scripts.git/snapshot/udev-gentoo-scripts-35.tar.bz2"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0105-procps-ng.log
tar -xf src/udev-gentoo-scripts-35.tar.bz2
cd udev-gentoo-scripts-35

make DESTDIR=/ install

cd ../
rm -rf udev-gentoo-scripts-35
