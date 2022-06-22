#!/bin/bash
#name="kbd"
#version"2.4.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.iij.ad.jp/pub/linux/kernel/linux/utils/kbd/kbd-2.4.0.tar.xz"
#
#}
#depend{
#	"Linux-PAM"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0104-kbd.log
tar -xf src/kbd-2.4.0.tar.xz
cd kbd-2.4.0


sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
mkdir build
cd build


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"	\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static

make -j24


make check  | tee ../../logs/0104-kbd.log


make install


cd ../../
rm -rf kbd-2.4.0
