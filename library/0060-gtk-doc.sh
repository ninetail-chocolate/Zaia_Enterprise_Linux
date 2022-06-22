#!/bin/bash
#name="gtk-doc"
#version="1.33.2"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://download.gnome.org/sources/gtk-doc/1.33/gtk-doc-1.33.2.tar.xz"
#}
#depend{
#	"docbook-xml"
#	"docbook-xsl"
#	"itstool"
#	"libxslt"
#	"pygments"
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
tar -xf src/gtk-doc-1.33.2.tar.xz
cd gtk-doc-1.33.2


autoreconf -fiv
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf gtk-doc-1.33.2
