#!/bin/bash
#name="python3-docutils"
#version="0.18.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://downloads.sourceforge.net/docutils/docutils-0.18.1.tar.gz"
#}
#depend{
#	"python3"
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
tar -xf src/docutils-0.18.1.tar.gz
cd docutils-0.18.1



CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
python3 setup.py build


#ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


#ninja install
python3 setup.py install --optimize=1


cd ../
rm -rf docutils-0.18.1
