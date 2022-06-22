#!/bin/bash
#name="cups"
#version="2.4.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/OpenPrinting/cups/releases/download/v2.4.1/cups-2.4.1-source.tar.gz"
#}
#depend{
#	"gnutls"
#	"dbus"
#	"libusb"
#	"Linux-PAM"
#}
#groupdepend{
#		""
#	}
#replace{
#	""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0005-xmlto.log
tar -xf src/cups-2.4.1-source.tar.gz
cd cups-2.4.1

sed -i 's#@CUPS_HTMLVIEW@#firefox#' desktop/cups.desktop.in
sed -e "s/-Wno-format-truncation//" \
    -i configure \
    -i config-scripts/cups-compiler.m4


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--libdir=/usr/lib				\
	--localstatedir=/var				\
	--with-rundir=/run/cups				\
	--with-cups-user=lp				\
	--with-cups-group=lp				\
	--without-systemd				\
	--with-rcdir=/tmp/cupsinit			\
	--with-system-groups=lpadmin			\
	--enable-shared					\
	--disable-static

#make -j32


#make check -j32 | tee ../../logs/0005-xmlto.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

rm -rvf /tmp/cupsinit
make install
cat > /etc/init.d/cupsd <<EOF
#!/sbin/openrc-run
# Copyright 1999-2021 Gentoo Authors

description="The Common Unix Printing System daemon"
command="/usr/sbin/cupsd"
command_args="-f -c /etc/cups/cupsd.conf -s /etc/cups/cups-files.conf"
pidfile="/run/cupsd.pid"
start_stop_daemon_args="-b -m --pidfile ${pidfile}"

depend() {
	use net
	before nfs
	after logger
}

start_pre() {
	checkpath -q -d -m 0775 -o root:lp /var/cache/cups
	checkpath -q -d -m 0775 -o root:lp /var/cache/cups/rss
	checkpath -q -d -m 0755 -o root:lp /run/cups
	checkpath -q -d -m 0511 -o lp:lpadmin /run/cups/certs
EOF
chmod a+x /etc/init.d/cupsd
cat > /etc/pam.d/cups << "EOF"
# Begin /etc/pam.d/cups

auth    include system-auth
account include system-account
session include system-session

# End /etc/pam.d/cups
EOF


useradd -c "Cups Print User" -d /var/spool/cups -g lp -s /bin/false -u 9 lp
groupadd -g 19 lpadmin




cd ../
rm -rf cups-2.4.1
