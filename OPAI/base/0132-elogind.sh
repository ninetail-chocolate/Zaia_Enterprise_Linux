#!/bin/bash
#name="elogin-minimal"
#version"246.10"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O elogind-246.10.tar.gz https://github.com/elogind/elogind/archive/refs/tags/v246.10.tar.gz"
#	"http://ftp.riken.jp/pub/Linux/gentoo-portage/sys-auth/elogind/files/elogind-246.10-clang-undefined-symbol.patch"
#}
#depend{
#	"musl"
#	"gcompat"
#	"elogind-minimal"
#}
#groupdepend{
#	"xorg-core"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/elogind-246.10.tar.gz
cd elogind-246.10
patch -Np1 -i ../src/elogind-246.10-revert-polkit-automagic.patch


mkdir bld
cd bld

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"			\
LDFLAGS="-z nostart-stop-gc"				\
meson							\
	--prefix=/usr					\
	--buildtype=release				\
	--libdir=/usr/lib				\
	--sbindir=/usr/sbin				\
	--bindir=/usr/bin				\
	--sysconfdir=/etc				\
	--localstatedir=/var				\
	--mandir=/usr/share/man				\
	-Dcgroup-controller=elogind			\
	-Dhalt-path=/usr/sbin/halt			\
	-Drootlibexecdir=/usr/libexec/elogind		\
	-Ddbuspolicydir=/etc/dbus-1/system.d		\
	-Dreboot-path=/usr/sbin/reboot			\
	-Ddefault-hierarchy=hybrid			\
	-Ddefault-kill-user-processes=true 		\
	-Dpam=true					\
	-Dselinux=false					\
	-Dtests=false					\
../


ninja


#ninja test


DESTDIR=/ ninja install
ln -sfv  libelogind.pc /usr/lib/pkgconfig/libsystemd.pc
ln -sfvn elogind /usr/include/systemd
cat > /etc/init.d/elogind <<EOF
#!/sbin/openrc-run
supervisor=supervise-daemon

name="System login manager"
description="System service that manages user logins"
description_reload="Reload configuration without exiting"

command=/usr/libexec/elogind/elogind

depend() {
	need dbus

	# Make sure we start before any other display manager
	before display-manager
}

extra_started_commands="reload"

reload() {
	ebegin "Reloading configuration"
	$supervisor $RC_SVCNAME --signal HUP
	eend $?
}
EOF
chmod a+x /etc/init.d/elogind


cp -rvf  /etc/pam.d/system-session /etc/pam.d/system-session.elogind-befor.bak
cat >> /etc/pam.d/system-session << "EOF" &&
# Begin elogind addition

session  required    pam_loginuid.so
session  optional    pam_elogind.so

# End elogind addition
EOF
cat > /etc/pam.d/elogind-user << "EOF"
# Begin /etc/pam.d/elogind-user

account  required    pam_access.so
account  include     system-account

session  required    pam_env.so
session  required    pam_limits.so
session  required    pam_unix.so
session  required    pam_loginuid.so
session  optional    pam_keyinit.so force revoke
session  optional    pam_elogind.so

auth     required    pam_deny.so
password required    pam_deny.so

# End /etc/pam.d/elogind-user
EOF


rc-update add elogind sysinit


cd ../../
rm -rf elogind-246.10
