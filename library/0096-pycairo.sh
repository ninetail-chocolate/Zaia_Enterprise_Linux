#!/bin/bash
#name="pycairo"
#version="1.20.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/pygobject/pycairo/releases/download/v1.20.1/pycairo-1.20.1.tar.gz"
#}
#depend{
#	"cairo"
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
tar -xf src/pycairo-1.20.1.tar.gz
cd pycairo-1.20.1


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
python3 setup.py build



#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


python3 setup.py install --optimize=1
python3 setup.py install_pycairo_header
python3 setup.py install_pkgconfig


cd ../
rm -rf pycairo-1.20.1
