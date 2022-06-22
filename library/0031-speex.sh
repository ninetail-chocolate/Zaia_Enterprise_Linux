#!/bin/bash
#name="speex"
#version="1.2.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.xiph.org/releases/speex/speex-1.2.0.tar.gz"
#}
#depend{
#	"libogg"
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


source /etc/profile

#touch logs/0030-flac.log
tar -xf src/speex-1.2.0.tar.gz
cd speex-1.2.0


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static			\
	--enable-binaries

make -j32


#ninja test -j32 | tee ../../logs/0030-flac.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf speex-1.2.0
