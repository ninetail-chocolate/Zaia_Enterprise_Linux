#!/bin/bash
#name="pciutils"
#version="3.7.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://mirrors.edge.kernel.org/pub/software/utils/pciutils/pciutils-3.7.0.tar.xz"
#}
#depend{
#	"curl"
#	"wget"
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


#touch logs/0008-yasm.log
tar -xf src/pciutils-3.7.0.tar.xz
cd pciutils-3.7.0



make					\
	CC=clang			\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"           \
	PREFIX=/usr			\
	SHAREDIR=/usr/share/hwdata	\
	SHARED=yes			\
	ZLIB=no -j32




#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make PREFIX=/usr SHARED=yes install install-lib
chmod -v 755 /usr/lib/libpci.so
mkdir -pv  /usr/share/hwdata

/usr/sbin/update-pciids


cd ../
rm -rf pciutils-3.7.0
