#!/bin/bash
#name="xkeyboardconfig"
#version"2.33"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.33.tar.bz2"
#}
#depend{
#	""
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

tar -xf src/xkeyboard-config-2.33.tar.bz2
cd xkeyboard-config-2.33


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
	--with-xkb-rules-symlink=xorg


make -j32


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


make install


cd ../../
rm -rf xkeyboard-config-2.33
