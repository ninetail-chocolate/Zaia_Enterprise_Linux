#!/bin/bash
#name="xvidcore"
#version="1.3.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz"
#}
#depend{
#	"yasm"
#	"nasm"
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

#touch logs/0038-libvpx.log
tar -xf src/xvidcore-1.3.7.tar.gz
cd xvidcore


cd build/generic
sed -i 's/^LN_S=@LN_S@/& -f -v/' platform.inc.in


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


sed -i '/libdir.*STATIC_LIB/ s/^/#/' Makefile 
make install
chmod -v 755 /usr/lib/libxvidcore.so.4.3


cd ../../../
rm -rf xvidcore
