#!/bin/bash
#name="Xtcs-util-linux"
#version"2.38"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.riken.jp/Linux/kernel.org/linux/utils/util-linux/v2.38/util-linux-2.38.tar.xz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/util-linux-2.38.tar.xz
cd util-linux-2.38


mkdir build
cd build

mkdir -pv /var/lib/hwclock
CC=clang	\
CXX=clang++	\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-zel-linux -flto=full"	\
../configure						\
	--prefix=/usr					\
	--bindir=/usr/bin				\
	--sbindir=/usr/sbin				\
	--sysconfdir=/etc				\
	--mandir=/usr/share/man				\
	--infodir=/usr/share/info			\
	--localstatedir=/var				\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--enable-shared					\
	--disable-static				\
	ADJTIME_PATH=/var/lib/hwclock/adjtime		\
	--libdir=/usr/lib				\
	--disable-chfn-chsh				\
	--disable-login					\
	--disable-nologin				\
	--disable-su					\
	--disable-setpriv				\
	--disable-runuser				\
	--disable-pylibmount				\
	--without-python				\
	runstatedir=/run

make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf util-linux-2.38
