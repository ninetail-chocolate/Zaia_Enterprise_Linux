#!/bin/bash
#name="Xtcs-gettext"
#version"0.21"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.gnu.org/gnu/gettext/gettext-0.21.tar.xz"
#}
#depend{
#	"pre-Xtcs-llvm-projects"
#	"pre-Xtcs-lld"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/gettext-0.21.tar.xz
cd gettext-0.21


mkdir build
cd build


CC=clang	\
CXX=clang++	\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" --target=x86_64-zel-linux-musl -flto=full"	\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--disable-shared


make -j24


cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin


cd ../../
rm -rf gettext-0.21
