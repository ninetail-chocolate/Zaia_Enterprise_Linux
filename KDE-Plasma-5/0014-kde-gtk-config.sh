#!/bin/bash
#name="kde-gtk-config"
#version="5.24.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.kde.org/stable/plasma/5.24.3/kde-gtk-config-5.24.3.tar.xz"
#}
#depend{
#	"gsettings-desktop-schemas"
#	"plasma-disks"
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
tar -xf src/kde-gtk-config-5.24.3.tar.xz
cd kde-gtk-config-5.24.3


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


cd ../../
rm -rf kde-gtk-config-5.24.3
