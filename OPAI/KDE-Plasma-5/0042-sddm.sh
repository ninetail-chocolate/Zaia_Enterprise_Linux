#!/bin/bash
#name="sddm"
#version="develop"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/sddm/sddm/archive/refs/heads/develop.zip"
#}
#depend{
#	"Linux-PAM"
#	"elogind"
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
unzip src/develop.zip
cd sddm-develop


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
cmake							\
	-DCMAKE_INSTALL_PREFIX=$KF5_PREFIX		\
	-DCMAKE_PREFIX_PATH=$QT5DIR			\
	-DCMAKE_INSTALL_LIBDIR=lib			\
	-DCMAKE_BUILD_TYPE=RELEASE			\
	-DUSE_ELOGIND="ON"				\
	-DNO_SYSTEMD="ON"				\
	-DDBUS_CONFIG_DIR=/usr/share/dbus-1/system.d	\
	-Wno-dev					\
	-G Ninja					\
	../

ninja


#ninja test | tee ../../logs/0002-phonon.log


#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install
cat > /etc/init.d/sddm <<EOF
#!/sbin/openrc-run

name="Display Manager"
description="SDDM Display Manager"

command=/usr/bin/sddm
command_args="$sddm_opts"

depends() {
	provide display-manager
	needs localmount
}

start_pre() {
	checkpath -d -o sddm:video -m755 /var/lib/sddm
}
EOF
chmod a+x /etc/init.d/sddm
cat > /etc/conf.d/sddm <<EOF
supervisor=supervise-daemon
EOF


useradd -c "SDDM daemon user" -d /var/lib/sddm   -s /bin/false -u 41 -m  sddm
usermod -a -G video sddm



cd ../../
rm -rf sddm-develop
