#!/bin/bash
#name="libblockdev"
#version="2.26"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/storaged-project/libblockdev/releases/download/2.26-1/libblockdev-2.26.tar.gz"
#}
#depend{
#	"gobject-introspection"
#	"libbytesize"
#	"libyaml"
#	"parted"
#	"volume_key"
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
tar -xf src/libblockdev-2.26.tar.gz
cd libblockdev-2.26


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
	--with-python3				\
	--without-gtk-doc			\
	--without-nvdimm			\
	--without-dm 


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libblockdev-2.26
