#!/bin/bash
#name="lm-sensors"
#version="3.6.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/lm-sensors/lm-sensors/archive/V3-6-0/lm-sensors-3-6-0.tar.gz"
#}
#depend{
#	"which"
#}
#groupdepend{
#		""
#	}
#replace{
#	""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0038-libvpx.log
tar -xf src/lm-sensors-3-6-0.tar.gz
cd lm-sensors-3-6-0

make						\
CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	PREFIX=/usr		\
	BUILD_STATIC_LIB=0	\
	MANDIR=/usr/share/man



#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


make					\
	PREFIX=/usr			\
	BUILD_STATIC_LIB=0		\
	MANDIR=/usr/share/man install


cd ../
rm -rf lm-sensors-3-6-0
