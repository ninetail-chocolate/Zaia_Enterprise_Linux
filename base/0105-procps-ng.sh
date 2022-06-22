#!/bin/bash
#name="procps-ng"
#version"2.4.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-3.3.17.tar.xz"
#	"wget -O musl-procps.patch https://git.alpinelinux.org/aports/plain/main/procps/musl-fixes.patch"
#
#}
#depend{
#	"musl"
#	"ncurses"
#	"libintl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0105-procps-ng.log
tar -xf src/procps-ng-3.3.17.tar.xz
cd procps-3.3.17


patch -Np1 -i ../src/musl-procps.patch
pwd
#cat w.c | sed '25i #include <utmp.h>' > w.c	
#cat proc/escape.c  | sed '19i #include <langinfo.h>' > proc/escape.c	
#sed -i 's/libtoolize/libtoolize-GNU/g' autogen.sh


#./autogen.sh
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
	--disable-static			\
	--disable-kill

make -j24


make check  | tee ../../logs/0105-procps-ng.log


make install


cd ../../
rm -rf procps-3.3.17
