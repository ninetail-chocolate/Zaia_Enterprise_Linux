#!/bin/bash
#name="gyp"
#version="none"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"git clone https://chromium.googlesource.com/external/gyp"
#}
#depend{
#	"git"
#	"python3"
#	"six"
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


mkdir gyp
cd gyp
git clone https://chromium.googlesource.com/external/gyp
cd gyp


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib=libc++ -rtlib=compiler-rt -unwindlib=libunwind -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
python3 setup.py build



#make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


#make install
python3 setup.py install



cd ../../
rm -rf gyp
