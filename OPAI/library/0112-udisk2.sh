#!/bin/bash
#name="udisk2"
#version="2.94"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/storaged-project/udisks/releases/download/udisks-2.9.4/udisks-2.9.4.tar.bz2"
#}
#depend{
#	"gobject-introspection"
#	"libatasmart"
#	"libblockdev"
#	"libgudev"
#	"libxslt"
#	"polkit"
#	"dbus"
#	"elogind"
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


#touch logs/0038-libvpx.log
tar -xf src/udisks-2.9.4.tar.bz2
cd udisks-2.9.4


sed -i -e 's/-ffast-math//g' configure
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--localstatedir=/var			\
	--enable-shared				\
	--disable-static			\
	--disable-man


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf udisks-2.9.4
