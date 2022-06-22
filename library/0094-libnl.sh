#!/bin/bash
#name="libnl"
#version="3.5.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/thom311/libnl/releases/download/libnl3_5_0/libnl-3.5.0.tar.gz"
#	"https://git.alpinelinux.org/aports/plain/main/libnl3/libnl3-musl.patch"
#}
#depend{
#	"musl"
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
tar -xf src/libnl-3.5.0.tar.gz
cd libnl-3.5.0


patch -Np1 -i ../src/libnl3-musl.patch
autoreconf -vif


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--disable-static			\
	--enable-shared


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf libnl-3.5.0
