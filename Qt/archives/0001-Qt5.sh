#!/bin/bash
#name="Qt5"
#version="5.15.3"
#zel-version="1"
#comment{
#	"WTF!?"
#	"build succusessed!!"
#}
#src={
#	"https://download.qt.io/archive/qt/5.15/5.15.3/single/qt-everywhere-opensource-src-5.15.3.tar.xz"
#	"wget -O qt5-llvm13.patch https://bz-attachments.freebsd.org/attachment.cgi?id=228850"
#}
#depend{
#	"xorg-server"
#	"alsa-lib"
#	"make-ca"
#	"cups"
#	"glib"
#	"harfbuzz"
#	"icu"
#	"jasper"
#	"libjpeg-turbo"
#	"libpng"
#	"libtiff"
#	"libwebp"
#	"libxkbcommon"
#	"mesa"
#	"krb5"
#	"mtdev"
#	"pcre2"
#	"sqlite"
#	"wayland"
#	"xcb-util-image"
#	"xcb-util-keysyms"
#	"xcb-util-renderutil"
#	"xcb-util-wm"
#	"pciutils"
#	"libbacktrace"
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


#touch logs/0018-pcre2.log
tar -xf src/qt-everywhere-opensource-src-5.15.3.tar.xz
cd qt-everywhere-src-5.15.3


cd qtbase/mkspecs/linux-clang
patch qplatformdefs.h < ../../../../src/musl-Qt5-5.15.3.patch
cd ../../../
pwd
cd qtwayland/src/hardwareintegration/compositor/linux-dmabuf-unstable-v1
pwd
patch linuxdmabuf.h <  ../../../../../../src/qtwayland-llvm13.patch
pwd
cd ../../../../../
pwd

mkdir build
cd build

../configure					\
QMAKE_CC=clang					\
QMAKE_CXX=clang++					\
QMAKE_CFLAGS+="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
QMAKE_CXXFLAGS+="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
QMAKE_LFLAGS="-Wl,-lexecinfo"		\
	-prefix /usr				\
	-sysconfdir /etc/xdg			\
	-confirm-license			\
	-opensource				\
	-dbus-linked				\
	-openssl-linked				\
	-system-harfbuzz			\
	-system-sqlite				\
	-nomake examples			\
	-no-rpath				\
	-syslog					\
	-skip qtwebengine			\
	-skip qtlocation			\
	-jasper					\
	-mng					\
	-system-tiff				\
	-system-webp				\
	-qt3d-simd avx2				\
	-system-sqlite				\
	-system-libpng				\
	-qt-libjpeg				\
	-system-pcre				\
	-system-zlib				\
	-platform linux-clang-libc++		\
	-no-pch
	

time make -j32


#make check -j32 | tee ../../logs/0018-pcre2.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


#make install


cd ../../
#rm -rf qt-everywhere-src-5.15.3
