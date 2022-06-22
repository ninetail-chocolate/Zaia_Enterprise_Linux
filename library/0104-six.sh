#!/bin/bash
#name="six"
#version="1.16.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://files.pythonhosted.org/packages/source/s/six/six-1.16.0.tar.gz"
#}
#depend{
#	"python"
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


tar -xf src/six-1.16.0.tar.gz
cd six-1.16.0


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



cd ../
rm -rf six-1.16.0
