#!/bin/bash
#name="otcs-libucontext"
#version"1.1"
#zel-version="2"
#comment{
#	WTF!?
#	"from alpine"
#}
#src={
#	"http://distcache.freebsd.org/local-distfiles/itetcu/libexecinfo-1.1.tar.bz2"
#	"https://git.alpinelinux.org/aports/plain/main/libexecinfo/10-execinfo.patch"
#	"https://git.alpinelinux.org/aports/plain/main/libexecinfo/20-define-gnu-source.patch"
#	"https://git.alpinelinux.org/aports/plain/main/libexecinfo/30-linux-makefile.patch"
#}
#depend{
#	"none"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/libexecinfo-1.1.tar.bz2
cd libexecinfo-1.1


patch -Np1 -i ../src/10-execinfo.patch
patch -Np1 -i ../src/20-define-gnu-source.patch
patch -Np1 -i ../src/30-linux-makefile.patch

cc=/usr/bin/clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -fno-omit-frame-pointer --target="x86_64-zel-linux-gnu" "	\
make


install -D -m755 -v execinfo.h           $ZEL/tools/include/execinfo.h
install -D -m755 -v stacktraverse.h      $ZEL/tools/include/stacktraverse.h
install -D -m755 -v libexecinfo.a        $ZEL/tools/lib/libexecinfo.a
install -D -m755 -v libexecinfo.so.1     $ZEL/tools/lib/libexecinfo.so.1
ln -sv libexecinfo.so.1   $ZEL/tools/lib/libexecinfo.so


cd ../
rm -rf libexecinfo-1.1
