#!/bin/bash
#name="musl"
#version"1.2.2"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://musl.libc.org/releases/musl-1.2.2.tar.gz"
#	"https://gitlab.alpinelinux.org/alpine/aports/-/raw/bf5bbfdbf780092f387b7abe401fbfceda90c84d/main/musl/qsort_r.patch"
#}
#depend{
#	"iana-etc"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/musl-1.2.2.tar.gz
cd musl-1.2.2

patch -Np1 -i ../src/qsort_r.patch
mkdir build
cd build


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl -fuse-ld=lld"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl -fuse-ld=lld"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--mandir=/usr/share/man			\
	--infodir=/usr/share/info		\
	--localstatedir=/var

time make -j24


make  install
cp ../../src/getent.c ./getent.c
clang -march=znver1 -O2 -pipe -fPIC getent.c -o getent
cp -rvf ./getent /usr/bin/getent
chmod a+x /usr/bin/getent

#rm -rf $ZEL/lib/ld-musl-x86_64.so.1
#ln -sv ../lib/libc.so $ZEL/lib/ld-musl-x86_64.so.1
#mkdir $ZEL/bin
#ln -sv ../lib/libc.so $ZEL/bin/ldd

cd ../../
rm -rf musl-1.2.2
