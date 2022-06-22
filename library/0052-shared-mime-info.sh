#!/bin/bash
#name="shared-mime-info"
#version=""
#zel-version="1"
#comment{
#	WTF!?
#	"need meson 0.59.1"
#	"not compatible meson 0.6XX"
#}
#src={
#	"https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.1/shared-mime-info-2.1.tar.gz"
#}
#depend{
#	"glib"
#	"libxml"
#	"xmlto"
#	"itstool"
#	"ninja"
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
tar -xf src/shared-mime-info-2.1.tar.gz
cd shared-mime-info-2.1


mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--buildtype=release			\
	-Dupdate-mimedb=true			\
	../

pwd
#meson compile -j12 -C build
ninja -j1


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


#DESTDIR=./ ninja install
ninja install


cd ../../
rm -rf shared-mime-info-2.1
