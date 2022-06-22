#!/bin/bash
#name="xf86-input-libinput"
#version="1.2.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/archive//individual/driver/xf86-input-libinput-1.2.1.tar.xz"
#}
#depend{
#	"xorg-server"
#	"libinput"
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

tar -xf src/xf86-input-libinput-1.2.1.tar.xz
cd xf86-input-libinput-1.2.1


mkdir build
cd build

../configure						\
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


cd ../../
rm -rf xf86-input-libinput-1.2.1
