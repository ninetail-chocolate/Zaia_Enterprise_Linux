#!/bin/bash
#name="LVM2"
#version="2.03.15"
#zel-version="1"
#comment{
#	"will be move to base groups"
#}
#src={
#	"https://sourceware.org/ftp/lvm2/LVM2.2.03.15.tgz"
#	"https://git.alpinelinux.org/aports/plain/main/lvm2/mallinfo.patch"
#	"https://git.alpinelinux.org/aports/plain/main/lvm2/fix-stdio-usage.patch"
#}
#depend{
#	"musl"
#	"libaio"
#	"ncurses"
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
tar -xf src/LVM2.2.03.15.tgz
cd LVM2.2.03.15



patch -Np1 -i ../src/mallinfo.patch
patch -Np1 -i ../src/fix-stdio-usage.patch
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
PYTHON=/usr/bin/python3				\
../configure					\
	--prefix=/usr				\
	--enable-cmdlib				\
	--enable-pkgconfig			\
	--enable-udev_sync			\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf LVM2.2.03.15
