#!/bin/bash
#name="pre-Xtcs-bash"
#version"5.2.0"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.gnu.org/gnu/bash/bash-5.2-alpha.tar.gz"
#}
#depend{
#	"pre-Xtcs-ncurses"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/bash-5.2-alpha.tar.gz
cd bash-5.2-alpha


mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--mandir=/usr/share/man			\
	--infodir=/usr/share/info		\
	--localstatedir=/var			\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--without-bash-malloc			\
	--with-curses


time make -j12


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

make DESTDIR=$ZEL install
ln -sv bash $ZEL/bin/sh


cd ../../
rm -rf bash-5.2-alpha
