#!/bin/bash
#name="Linux-PAM"
#version"1.5.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/linux-pam/linux-pam/releases/download/v1.5.2/Linux-PAM-1.5.2.tar.xz"
#
#}
#depend{
#	"libnsl"
#	"libtirpc"
#	"audit"
#	"libselinux"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0035-Linux-PAM.log
tar -xf src/Linux-PAM-1.5.2.tar.xz
cd Linux-PAM-1.5.2


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--disable-static				\
	--prefix=/usr					\
	--sysconfdir=/etc				\
	--sbindir=/usr/sbin				\
	--libdir=/usr/lib				\
	--enable-securedir=/usr/lib/security


make -j24


install -v -m755 -d /etc/pam.d
cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF
make check -j24 | tee ../../logs/0035-Linux-PAM.log
rm -fv /etc/pam.d/other


make install -j24
chmod -v 4755 /usr/sbin/unix_chkpwd
install -vdm755 /etc/pam.d &&
cat > /etc/pam.d/system-account << "EOF" &&
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF
cat > /etc/pam.d/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF
cat > /etc/pam.d/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF
cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use sha512 hash for encryption, use shadow, and try to use any previously
# defined authentication token (chosen password) set by any prior module
password  required    pam_unix.so       sha512 shadow try_first_pass

# End /etc/pam.d/system-password
EOF
cat > /etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth        required        pam_warn.so
auth        required        pam_deny.so
account     required        pam_warn.so
account     required        pam_deny.so
password    required        pam_warn.so
password    required        pam_deny.so
session     required        pam_warn.so
session     required        pam_deny.so

# End /etc/pam.d/other
EOF


cd ../../
rm -rf Linux-PAM-1.5.2
