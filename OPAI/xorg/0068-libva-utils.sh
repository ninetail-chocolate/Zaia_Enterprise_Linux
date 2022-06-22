#!/bin/bash
#name="libva-utils"
#version="2.14.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O libva-utils-2.14.0.tar.gz https://github.com/intel/libva-utils/archive/refs/tags/2.14.0.tar.gz"
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

tar -xf src/libva-utils-2.14.0.tar.gz
cd libva-utils-2.14.0


./autogen.sh
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
rm -rf libva-utils-2.14.0
