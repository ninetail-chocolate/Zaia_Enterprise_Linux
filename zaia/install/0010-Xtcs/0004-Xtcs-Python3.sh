#!/bin/bash
#name="chtcs-2nd-Python3"
#version"3.10.4"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tar.xz"
#}
#depend{
#	"not"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/Python-3.10.4.tar.xz
cd Python-3.10.4


mkdir build
cd build


CC=clang	\
CXX=clang++	\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
../configure				\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--prefix=/usr			\
	--enable-shared			\
	--without-ensurepip		\
	ax_cv_c_float_words_bigendian=no


make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install


cd ../../
rm -rf Python-3.10.4
