#!/bin/bash
#name="xterm"
#version="372"
#zel-version="2"
#src{
#	"https://invisible-mirror.net/archives/xterm/xterm-372.tgz"
#	"https://git.alpinelinux.org/aports/plain/community/xterm/posix-ptys.patch"
#   }
#depend{
#	"xinit"
#      }
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/xterm-372.tgz
cd xterm-372


patch -Np1 -i ../src/posix-ptys.patch
sed -i '/v0/{n;s/new:/new:kb=^?:/}' termcap &&
printf '\tkbs=\\177,\n' >> terminfo &&

TERMINFO=/usr/share/terminfo					\
./configure							\
	CC=clang						\
	CXX=clang++						\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"			\
	$XORG_CONFIG						\
	--with-app-defaults=/etc/X11/app-defaults
make


make install
make install-ti


mkdir -pv /usr/share/applications
cp -v *.desktop /usr/share/applications/
#cat >> /etc/X11/app-defaults/XTerm << "EOF"
#*VT100*locale: true
#*VT100*faceName: Regular
#*VT100*faceSize: 10
#*backarrowKeyIsErase: true
#*ptyInitialErase: true
#EOF


cd ../
rm -rf xterm-372
