#!/bin/bash
#name="xorg-server"
#version"21.1.3"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/archive//individual/xserver/xorg-server-21.1.3.tar.xz"
#}
#depend{
#	"pixman"
#	"font-util"
#	"xkeyboardconfig"
#	"polkit"
#	"wayland"
#	"libeproxy"
#	"elogind"
#	"libxcvt"
#}
#groupdepend{
#		"xorg-core"
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

source /etc/profile.d/xorg.sh

tar -xf src/xorg-server-21.1.3.tar.xz
cd xorg-server-21.1.3


mkdir build
cd build

../configure						\
	CC=clang					\
	CXX=clang++					\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	--build=x86_64-zel-linux-musl			\
	--host=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	$XORG_CONFIG					\
	--disable-systemd-logind			\
	--enable-glamor					\
	--enable-suid-wrapper				\
	--with-xkb-output=/var/lib/xkb


make -j32


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


make install
mkdir -pv /etc/X11/xorg.conf.d &&
cat >> /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF


cd ../../
rm -rf xorg-server-21.1.3
