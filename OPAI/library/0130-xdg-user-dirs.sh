#!/bin/bash
#name="xdg-user-dirs"
#version="0.17"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"http://user-dirs.freedesktop.org/releases/xdg-user-dirs-0.17.tar.gz"
#}
#depend{
#	"autoconf"
#	"automake"
#	"libtool"
#	"gettext"
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
tar -xf src/xdg-user-dirs-0.17.tar.gz
cd xdg-user-dirs-0.17


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--enable-shared				\
	--disable-static			\
	--disable-documentation

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf xdg-user-dirs-0.17
