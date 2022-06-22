#!/bin/bash
#name="networkmanager"
#version"1.37.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.gnome.org/sources/NetworkManager/1.37/NetworkManager-1.37.1.tar.xz"
#}
#depend{
#	"jansson"
#	"libndp"
#	"newt"
#	"dbus"
#	"polkit"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/NetworkManager-1.37.1.tar.xz
cd NetworkManager-1.37.1


mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
meson					\
	--buildtype=release		\
	--prefix=/usr			\
	-Dlibaudit=yes			\
	-Dlibpsl=false			\
	-Dnmtui=true			\
	-Dovs=false			\
	-Dppp=false			\
	-Dselinux=false			\
	-Dsession_tracking=elogind	\
	-Dmodem_manager=false		\
	-Dsystemdsystemunitdir=false	\
	-Dsystemd_journal=false		\
	-Dqt=false			\
	-Dld_gc=false			\
	-Dcrypto=null			\
../

ninja


#make check -j32 | tee ../logs/0122-jansson.log


ninja install
cat > /etc/init.d/networkmanager <<EOF
#!/sbin/openrc-run
# Copyright (c) 2008 Saleem Abdulrasool <compnerd@compnerd.org>
# Distributed under the terms of the GNU General Purpose License v2
# $Header: $

supervisor=supervise-daemon
command=/usr/sbin/NetworkManager
command_args_foreground="-n"

description="Network Manager Daemon"

depend() {
   need dbus
   provide net
}

# vim: set ft=gentoo-init-d ts=3 sw=3 et:
EOF
chmod a+x /etc/init.d/networkmanager

rc-update add networkmanager sysinit


cd ../../
rm -rf NetworkManager-1.37.1
