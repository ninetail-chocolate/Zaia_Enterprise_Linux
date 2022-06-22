#!/bin/bash
#name="Qt5"
#version="5.15.3"
#zel-version="1"
#comment{
#	WTF!?
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
#	"libexecinfo"
#	"vulkan-headers"
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

source /etc/profile

tar -xf src/qt-everywhere-opensource-src-5.15.3.tar.xz
cd qt-everywhere-src-5.15.3


cd qtbase/mkspecs/linux-clang
patch qplatformdefs.h < ../../../../src/musl-Qt5-5.15.3.patch
cd ../../../
cd qtwayland/src/hardwareintegration/compositor/linux-dmabuf-unstable-v1
patch linuxdmabuf.h <  ../../../../../../src/qtwayland-llvm13.patch
cd ../../../../../

mkdir build
cd build

../configure					\
QMAKE_CC=clang					\
QMAKE_CXX=clang++					\
QMAKE_CFLAGS+="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
QMAKE_CXXFLAGS+="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
QMAKE_LFLAGS="-Wl,-lexecinfo"				\
	-prefix /usr					\
	-sysconfdir /etc/xdg				\
	-archdatadir /usr/lib/qt5			\
	-bindir /usr/bin				\
	-plugindir /usr/lib/qt5/plugins			\
	-importdir /usr/lib/qt5/imports			\
	-headerdir /usr/include/qt5			\
	-datadir /usr/share/qt5				\
	-docdir /usr/share/doc/qt5			\
	-translationdir /usr/share/qt5/translations	\
	-examplesdir /usr/share/doc/qt5/examples	\
	-confirm-license				\
	-opensource					\
	-dbus-linked					\
	-openssl-linked					\
	-system-harfbuzz				\
	-system-sqlite					\
	-nomake examples				\
	-no-rpath					\
	-syslog						\
	-skip qtwebengine				\
	-skip qtlocation				\
	-jasper						\
	-mng						\
	-system-tiff					\
	-system-webp					\
	-qt3d-simd avx2					\
	-system-sqlite					\
	-system-libpng					\
	-qt-libjpeg					\
	-system-pcre					\
	-system-zlib					\
	-platform linux-clang-libc++
	

time make -j32


#make check -j32 | tee ../../logs/0018-pcre2.log


#mkdir DEST
#make INSTALL_ROOT=$(pwd)/DEST install


make install

find /usr/ -name \*.prl	\
   -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \;
QT5BINDIR=/usr/bin
install -v -dm755 /usr/share/pixmaps/
install -v -Dm644 ../qttools/src/assistant/assistant/images/assistant-128.png \
                  /usr/share/pixmaps/assistant-qt5.png
install -v -Dm644 ../qttools/src/designer/src/designer/images/designer.png \
                  /usr/share/pixmaps/designer-qt5.png
install -v -Dm644 ../qttools/src/linguist/linguist/images/icons/linguist-128-32.png \
                  /usr/share/pixmaps/linguist-qt5.png
install -v -Dm644 ../qttools/src/qdbus/qdbusviewer/images/qdbusviewer-128.png \
                  /usr/share/pixmaps/qdbusviewer-qt5.png
install -dm755 /usr/share/applications
cat > /usr/share/applications/assistant-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Assistant
Comment=Shows Qt5 documentation and examples
Exec=$QT5BINDIR/assistant
Icon=assistant-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Documentation;
EOF

cat > /usr/share/applications/designer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Designer
GenericName=Interface Designer
Comment=Design GUIs for Qt5 applications
Exec=$QT5BINDIR/designer
Icon=designer-qt5.png
MimeType=application/x-designer;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF

cat > /usr/share/applications/linguist-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Linguist
Comment=Add translations to Qt5 applications
Exec=$QT5BINDIR/linguist
Icon=linguist-qt5.png
MimeType=text/vnd.trolltech.linguist;application/x-linguist;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF

cat > /usr/share/applications/qdbusviewer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 QDbusViewer
GenericName=D-Bus Debugger
Comment=Debug D-Bus applications
Exec=$QT5BINDIR/qdbusviewer
Icon=qdbusviewer-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Debugger;
EOF

echo "#######################################################"
echo "for VLC"
for file in moc uic rcc qmake lconvert lrelease lupdate; do
  ln -sfrvn $QT5BINDIR/$file /usr/bin/$file-qt5
done
echo "#######################################################"

cat > /etc/profile.d/qt5.sh << "EOF"
# Begin /etc/profile.d/qt5.sh

QT5DIR=/usr
export QT5DIR
pathappend $QT5DIR/bin

# End /etc/profile.d/qt5.sh
EOF



cd ../../
rm -rf qt-everywhere-src-5.15.3
