#!/bin/bash
#name="pre-Xtcs-ncurses"
#version"6.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.gnu.org/gnu/ncurses/ncurses-6.3.tar.gz"
#}
#depend{
#	"pre-Xtcs-m4"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/ncurses-6.3.tar.gz
cd ncurses-6.3


mkdir build
cd build


AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
../configure				\
	--prefix=/usr			\
	--sysconfdir=/etc		\
	--mandir=/usr/share/man		\
	--infodir=/usr/share/info	\
	--localstatedir=/var		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--with-manpage-format=normal	\
	--with-shared			\
	--without-debug			\
	--without-ada			\
	--without-normal		\
	--disable-stripping		\
	--enable-widec			\
	--enable-shared			\
	--disable-static


make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST TIC_PATH=$(pwd)/progs/tic install


make DESTDIR=$ZEL TIC_PATH=$(pwd)/progs/tic install
echo "INPUT(-lncursesw)" > $ZEL/usr/lib/libncurses.so


cd ../../
rm -rf ncurses-6.3
