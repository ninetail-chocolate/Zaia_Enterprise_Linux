#!/bin/bash
#name="dbus-minimal"
#version"1.14"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://dbus.freedesktop.org/releases/dbus/dbus-1.14.0.tar.xz"
#	"https://gitweb.gentoo.org/repo/gentoo.git/plain/sys-apps/dbus/files/dbus.initd.in"
#}
#depend{
#	"elogind"
#	"dbus-minimail"
#}
#groupdepend{
#	"xorg-core"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/dbus-1.14.0.tar.xz
cd dbus-1.14.0


mkdir build
cd build

../configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--host=x86_64-zel-linux-musl				\
	--build=x86_64-zel-linux-musl				\
	--prefix=/usr						\
	--sysconfdir=/etc					\
	--localstatedir=/var					\
	--disable-static					\
	--enable-shared						\
	-enable-user-session					\
	--disable-doxygen-docs					\
	--disable-xml-docs					\
	--with-session-socket-dir=/tmp				\
	--with-systemduserunitdir=no				\
	--with-systemdsystemunitdir=no				\
	--with-console-auth-dir=/run/console			\
	--with-system-pid-file=/run/dbus.pid			\
	--with-system-socket=/run/dbus/system_bus_socket	\
	--with-dbus-user=messagebus

make 


#make check -j32 | tee ../logs/0129-dbus.log


make install
install -Dm775 ../../src/dbus.initd.in /etc/init.d/dbus
mkdir -pv /run/dbus
ln -sv /var/lib/dbus/machine-id /etc

rc-update add udev sysinit


cd ../../
rm -rf dbus-1.14.0
