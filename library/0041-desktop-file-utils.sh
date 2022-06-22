#!/bin/bash
#name="desktop-file-utils"
#version="0.26"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.26.tar.xz"
#}
#depend{
#	"glib"
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


source /etc/profile

#touch logs/0038-libvpx.log
tar -xf src/desktop-file-utils-0.26.tar.xz
cd desktop-file-utils-0.26



mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--buildtype=release			\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf desktop-file-utils-0.26
