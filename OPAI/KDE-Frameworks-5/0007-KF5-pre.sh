#!/bin/bash
#name="KF5-pre"
#version="none"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	""
#}
#depend{
#	"plasma-wayland-protocols"
#	"boost"
#	"extra-cmake-modules"
#	"docbook-xml"
#	"docbook-xsl"
#	"giflib"
#	"libeproxy"
#	"libgcrypt"
#	"libical"
#	"libjpeg-turbo"
#	"libpng"
#	"libxslt"
#	"qrencode"
#	"phonon"
#	"shared-mime-info"
#	"wget"
#	"networkmanager"
#	"polkit-qt"
#	"jasper"
#	"krb5"
#	"upower"
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


export KF5_PREFIX=/usr
cat >> /etc/profile.d/qt5.sh << "EOF"
###################################################
# Begin kf5 extension for /etc/profile.d/qt5.sh
pathappend /usr/lib/qt5/plugins    QT_PLUGIN_PATH
pathappend $QT5DIR/lib/plugins     QT_PLUGIN_PATH

pathappend /usr/lib/qt5/qml        QML2_IMPORT_PATH
pathappend $QT5DIR/lib/qml         QML2_IMPORT_PATH

# End extension for /etc/profile.d/qt5.sh
###################################################
EOF

cat > /etc/profile.d/kf5.sh << "EOF"
############################################
# Begin /etc/profile.d/kf5.sh

export KF5_PREFIX=/usr

# End /etc/profile.d/kf5.sh
###########################################
EOF
cat >> /etc/sudoers.d/qt << "EOF"
###########################################
Defaults env_keep += QT_PLUGIN_PATH
Defaults env_keep += QML2_IMPORT_PATH
EOF
cat >> /etc/sudoers.d/kde << "EOF"
Defaults env_keep += KF5_PREFIX
############################################
EOF
