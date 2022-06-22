#!/bin/bash
#name="itstool"
#version="2.0.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://files.itstool.org/itstool/itstool-2.0.7.tar.bz2"
#	"https://git.alpinelinux.org/aports/plain/main/itstool/fix-segfault.patch"
#}
#depend{
#	"musl"
#	"python3"
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
tar -xf src/itstool-2.0.7.tar.bz2
cd itstool-2.0.7


patch -Np1 -i ../src/fix-segfault.patch
autoreconf -vif

mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
PYTHON=/usr/bin/python3				\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--mandir=/usr/share/man			\
	--infodir=/usr/share/info		\
	--localstatedir=/var			\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf itstool-2.0.7
