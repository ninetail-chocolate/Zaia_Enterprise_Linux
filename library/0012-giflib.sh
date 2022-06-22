#!/bin/bash
#name="giflib"
#version="5.2.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/giflib/files/giflib-5.2.1.tar.gz"
#}
#depend{
#	"xmlto"
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
tar -xf src/giflib-5.2.1.tar.gz
cd giflib-5.2.1



CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
make -j32




#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make PREFIX=/usr install


cd ../
rm -rf giflib-5.2.1
