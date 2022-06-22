#!/bin/bash
#name="nss"
#version="3.69"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://archive.mozilla.org/pub/security/nss/releases/NSS_3_69_RTM/src/nss-3.69.tar.gz"
#}
#depend{
#	"nspr"
#	"gyp"
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
tar -xf src/nss-3.77.tar.gz
cd nss-3.77


patch -Np1 -i ../src/nss-3.69-standalone-1.patch
cd nss


#./build.sh --clang --python=python3 --system-nspr --system-sqlite --opt -c


CC=clang CXX=clang++					\
make	BUILD_OPT=1					\
	NSPR_INCLUDE_DIR=/usr/include/nspr		\
	USE_SYSTEM_ZLIB=1				\
	ZLIB_LIBS=-lz					\
	NSS_ENABLE_WERROR=0				\
	USE_64=1					\
	NSS_USE_SYSTEM_SQLITE=1				\
	-j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


cd ../dist    
install -v -m755 Linux*/lib/*.so              /usr/lib         
install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib         
install -v -m755 -d                           /usr/include/nss  
cp -v -RL {public,private}/nss/*              /usr/include/nss  
chmod -v 644                                  /usr/include/nss/*
install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin
install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig


cd ../../
#rm -rf nss-3.77
