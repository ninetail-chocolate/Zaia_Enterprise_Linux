#!/bin/bash
#name="pre-Xtcs-musl"
#version"1.2.2"
#zel-version="3"
#comment{
#	WTF!?
#}
#src={
#	"https://musl.libc.org/releases/musl-1.2.2.tar.gz"
#}
#depend{
#	"pre-Xtcs-zen-headers"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/musl-1.2.2.tar.gz
cd musl-1.2.2


mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind""	\
CXX=clang++				\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind""	\
../configure					\
	--sysroot=$ZEL				\
	--prefix=/usr				\
	--syslibdir=/usr/lib			\
	--sysconfdir=/etc			\
	--mandir=/usr/share/man			\
	--infodir=/usr/share/info		\
	--localstatedir=/var			\
	--target=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--enable-shared				\
	--enable-static


make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make DESTDIR=$ZEL install

mkdir $ZEL/usr/bin
ln -sv ../lib/libc.so $ZEL/usr/bin/ldd


cd ../../
rm -rf musl-1.2.2
