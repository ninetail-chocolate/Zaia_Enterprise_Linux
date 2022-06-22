#!/bin/bash
#name="openrc"
#version"38"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O openrc-0.44.10.tar.gz  https://github.com/OpenRC/openrc/archive/refs/tags/0.44.10.tar.gz"
#}
#depend{
#	"musl"
#	"eudev"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/openrc-0.44.10.tar.gz
cd openrc-0.44.10


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
meson							\
	--prefix=/usr					\
	--buildtype=release				\
	--libdir=/usr/lib				\
	--libexecdir=/usr/libexec/openrc		\
	--sbindir=/usr/sbin				\
	--bindir=/usr/bin				\
	--sysconfdir=/etc				\
	--localstatedir=/var				\
	--mandir=/usr/share/man				\
	-Dos=Linux					\
	-Dpam=true					\
	-Dshell=/bin/bash				\
	-Dsysvinit=true					\
	-Dtermcap=ncurses				\
../


ninja


ninja test



DESTDIR=/ ninja install
cp -rvf ../support/sysvinit/inittab /etc/inittab



###############AFTER SCRIPT############
rc-update add udev sysinit
rc-update add udev-trigger sysinit
#######################################


cd ../../
rm -rf openrc-0.44.10
