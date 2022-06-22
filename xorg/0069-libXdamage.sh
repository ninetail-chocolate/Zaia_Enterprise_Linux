#!/bin/bash
#name="libXdamage"
#version="1.1.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://xorg.freedesktop.org/releases/individual/lib/libXdamage-1.1.5.tar.gz"
#}
#depend{
#	"libva"
#	"mesa"
#	"wayland"
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

source /etc/profile.d/xorg.sh

tar -xf src/libXdamage-1.1.5.tar.gz
cd libXdamage-1.1.5


./configure						\
	CC=clang					\
	CXX=clang++					\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	$XORG_CONFIG


make -j32


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


make install


cd ../
rm -rf libXdamage-1.1.5
