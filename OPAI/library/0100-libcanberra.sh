#!/bin/bash
#name="libcanberra"
#version="0.30"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"http://0pointer.de/lennart/projects/libcanberra/libcanberra-0.30.tar.xz"
#	"https://www.linuxfromscratch.org/patches/blfs/svn/libcanberra-0.30-wayland-1.patch"
#}
#depend{
#	"libsassc"
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
tar -xf src/libcanberra-0.30.tar.xz
cd libcanberra-0.30


patch -Np1 -i ../src/libcanberra-0.30-wayland-1.patch
./autogen.sh
autoreconf -fvi
sed -i -e 's/-ffast-math//g' configure

mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib=libc++ -rtlib=compiler-rt -unwindlib=libunwind -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
CDEPMODE=none					\
CXXDEPMODE=none					\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--disable-oss				\
	--enable-fast-install="no"		\
	--disable-lynx

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf libcanberra-0.30
