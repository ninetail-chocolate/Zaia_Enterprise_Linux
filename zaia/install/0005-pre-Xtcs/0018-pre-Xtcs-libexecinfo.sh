#!/bin/bash
#name="pre-Xtcs-libucontext"
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
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/libexecinfo-1.1.tar.bz2
cd libexecinfo-1.1


ln -svf ./clang $ZEL/tools/bin/cc


patch -Np1 -i ../src/10-execinfo.patch
patch -Np1 -i ../src/20-define-gnu-source.patch
patch -Np1 -i ../src/30-linux-makefile.patch


CFLAGS="-march=znver1 -O2 -pipe -fPIC -fno-omit-frame-pointer --target="x86_64-zel-linux-musl" --sysroot=$ZEL -flto=full"	\
make


install -D -m755 -v execinfo.h           $ZEL/usr/include/execinfo.h
install -D -m755 -v stacktraverse.h      $ZEL/usr/include/stacktraverse.h
install -D -m755 -v libexecinfo.a        $ZEL/lib/libexecinfo.a
install -D -m755 -v libexecinfo.so.1     $ZEL/lib/libexecinfo.so.1
ln -sv libexecinfo.so.1   $ZEL/lib/libexecinfo.so


cd ../
rm -rf libexecinfo-1.1
rm -rf $ZEL/tools/bin/cc
