#!/bin/bash
#name="boost"
#version="1.78.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.tar.bz2"
#	"https://git.alpinelinux.org/aports/plain/main/boost1.77/0001-revert-cease-dependence-on-range.patch"
#}
#depend{
#	"icu"
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


source /etc/profile

touch logs/0044-boost.log
tar -xf src/boost_1_78_0.tar.bz2
cd boost_1_78_0


patch -Np1 -i ../src/0001-revert-cease-dependence-on-range.patch

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./bootstrap.sh					\
	--prefix=/usr				\
	--with-python=python3			\
	--with-toolset=clang

#ldd ./b2
./b2 stage -j32 threading=multi link=shared toolset=clang variant=release runtime-link=shared


#cd tools/build/test
#python3 test_all.py | tee ../../../../logs/0044-boost.log
#pwd 
#cd ../../../
#pwd


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


./b2 install threading=multi link=shared toolset=clang variant=release runtime-link=shared
#make install


cd ../
rm -rf boost_1_78_0
