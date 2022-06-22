#!/bin/bash
#name="xxhash"
#version="0.8.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"wget -O xxHash-0.8.1.tar.gz https://github.com/Cyan4973/xxHash/archive/refs/tags/v0.8.1.tar.gz"
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


source /etc/profile

#touch logs/0038-libvpx.log
tar -xf src/xxHash-0.8.1.tar.gz
cd xxHash-0.8.1


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
make PREFIX=/usr -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST  install


make PREFIX=/usr  install


cd ../
rm -rf xxHash-0.8.1
