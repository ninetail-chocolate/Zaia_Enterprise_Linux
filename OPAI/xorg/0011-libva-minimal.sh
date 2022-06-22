#!/bin/bash
#name="libva-minimal"
#version"2.14.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/intel/libva/releases/download/2.14.0/libva-2.14.0.tar.bz2"
#}
#depend{
#	"libdrm"
#	"wayland-protocols"
#}
#groupdepend{
#		""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile.d/xorg.sh

tar -xf src/libva-2.14.0.tar.bz2
cd libva-2.14.0


mkdir build
cd build

../configure						\
	CC=clang					\
	CXX=clang++					\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	$XORG_CONFIG					\


make -j32


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


make install


cd ../../
rm -rf libva-2.14.0
