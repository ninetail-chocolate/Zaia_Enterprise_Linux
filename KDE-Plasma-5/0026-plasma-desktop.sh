#!/bin/bash
#name="plasma-desktop"
#version="5.24.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.kde.org/stable/plasma/5.24.3/plasma-desktop-5.24.3.tar.xz"
#}
#depend{
#	"xwayland"
#	"powerdevil"
#}
#groupdepend{
#		"KDE-Frameworks-5"
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


source /etc/profile

#touch logs/0002-phonon.log
tar -xf src/plasma-desktop-5.24.3.tar.xz
cd plasma-desktop-5.24.3


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=$KF5_PREFIX	\
	-DCMAKE_PREFIX_PATH=$QT5DIR		\
	-DCMAKE_INSTALL_LIBDIR=lib		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-DBUILD_TESTING=OFF			\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#ninja test | tee ../../logs/0002-phonon.log


#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install
cat > /etc/pam.d/kde << "EOF"
# Begin /etc/pam.d/kde

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     include        system-auth

account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/kde
EOF

cat > /etc/pam.d/kde-np << "EOF"
# Begin /etc/pam.d/kde-np

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     required       pam_permit.so

account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/kde-np
EOF

cat > /etc/pam.d/kscreensaver << "EOF"
# Begin /etc/pam.d/kscreensaver

auth    include system-auth
account include system-account

# End /etc/pam.d/kscreensaver
EOF


cd ../../
rm -rf plasma-desktop-5.24.3
