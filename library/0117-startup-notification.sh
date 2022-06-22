#!/bin/bash
#name="startup-notification"
#version="0.12"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://www.freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz"
#}
#depend{
#	"xcb-util"
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


#touch logs/0038-libvpx.log
tar -xf src/startup-notification-0.12.tar.gz
cd startup-notification-0.12


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--enable-shared				\
	--disable-static			\
	--prefix=/usr				\
	--sysconfdir=/etc

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf startup-notification-0.12
