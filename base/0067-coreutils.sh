#!/bin/bash
#name="coreutils"
#version"9.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/coreutils/coreutils-9.0.tar.xz"
#
#}
#depend{
#	"libselinux"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0058-intltool.log
tar -xf src/coreutils-9.0.tar.xz
cd coreutils-9.0


mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
FORCE_UNSAFE_CONFIGURE=1				\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	--enable-no-install-program=kill,uptime


make -j24


#make check -j1 | tee ../../logs/0058-intltool.log


make install
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8


cd ../../
rm -rf coreutils-9.0
