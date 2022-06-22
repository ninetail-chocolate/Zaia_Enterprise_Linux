#!/bin/bash
#name="pre-Xtcs-lld"
#version"14.0.0"
#zel-version="2"
#comment{
#	"--sysroot depricated. You need use -isysroot=CUSTOMPATH"
#}
#src={
#	"https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/lld-14.0.0.src.tar.xz"
#	"https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/libunwind-14.0.0.src.tar.xz"
#}
#depend{
#	"pre-Xtcs-llvm-projects"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


mkdir LLD-14.0.0
cd LLD-14.0.0
tar -xf ../src/lld-14.0.0.src.tar.xz
tar -xf ../src/libunwind-14.0.0.src.tar.xz
cp -rvf libunwind-14.0.0.src/include/mach-o lld-14.0.0.src/include
rm -rvf libunwind-14.0.0.src
cd lld-14.0.0.src


mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" -D_LIBCPP_HAS_MUSL_LIBC -isysroot="$ZEL" -flto="full""			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" -D_LIBCPP_HAS_MUSL_LIBC -isysroot="$ZEL" -flto="full""			\
cmake						\
-DCMAKE_INSTALL_PREFIX="$ZEL/usr"		\
-DCMAKE_INSTALL_LIBDIR=lib			\
-DCMAKE_BUILD_TYPE=RELEASE			\
-Wno-dev					\
-G Ninja					\
../


ninja -j32


#mkdir DEST
#DESTDIR=./DEST ninja install
ninja install


pwd
cd ../../../
rm -rf LLD-14.0.0
