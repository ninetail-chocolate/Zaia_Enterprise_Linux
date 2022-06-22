#!/bin/bash
#name="pre-Xtcs-coreutils"
#version"9.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.gnu.org/gnu/coreutils/coreutils-9.0.tar.xz"
#}
#depend{
#	"pre-Xtcs-bash"
#}
#groupdepend{
#		"otcs"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/coreutils-9.0.tar.xz
cd coreutils-9.0


mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang			\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full "			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL -flto=full"			\
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
	--enable-install-program=hostname		\
	--enable-no-install-program=kill,uptime


make -j24


mkdir DEST
make DESTDIR=$(pwd)/DEST install


make DESTDIR=$ZEL install
mv -v $ZEL/usr/bin/chroot              $ZEL/usr/sbin
#mkdir -pv $ZEL/usr/share/man/man8
#mv -v $ZEL/usr/share/man/man1/chroot.1 $ZEL/usr/share/man/man8/chroot.8
#sed -i 's/"1"/"8"/'                    $ZEL/usr/share/man/man8/chroot.8


cd ../../
rm -rf coreutils-9.0
