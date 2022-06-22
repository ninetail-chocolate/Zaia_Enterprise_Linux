#!/bin/bash
#name="libpcap"
#version="1.10.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://www.tcpdump.org/release/libpcap-1.10.1.tar.gz"
#}
#depend{
#	"libusb"
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
tar -xf src/libpcap-1.10.1.tar.gz
cd libpcap-1.10.1


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--disable-static			\
	--enable-shared


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install

sed -i '/INSTALL_DATA.*libpcap.a\|RANLIB.*libpcap.a/ s/^/#/' Makefile
make install


cd ../../
rm -rf libpcap-1.10.1
