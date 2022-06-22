#!/bin/bash
#name="libmad"
#version="0.15.1b"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.sourceforge.net/mad/libmad-0.15.1b.tar.gz"
#	"https://www.linuxfromscratch.org/patches/blfs/svn/libmad-0.15.1b-fixes-1.patch"
#}
#depend{
#	"musl"
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
tar -xf src/libmad-0.15.1b.tar.gz
cd libmad-0.15.1b


patch -Np1 -i ../src/libmad-0.15.1b-fixes-1.patch
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
rm -rf libmad-0.15.1b
