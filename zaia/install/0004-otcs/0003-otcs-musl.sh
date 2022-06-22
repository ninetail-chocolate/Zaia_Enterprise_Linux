#!/bin/bash
#name="otcs-musl"
#version"1.2.2"
#zel-version="3"
#comment{
#	WTF!?
#}
#src={
#	"https://musl.libc.org/releases/musl-1.2.2.tar.gz"
#}
#depend{
#	"otcs-llvm-projects"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
tar -xf src/musl-1.2.2.tar.gz
cd musl-1.2.2

mkdir build
cd build

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL/tools"	\
CXX=clang++				\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot=$ZEL/tools"	\
../configure							\
	--prefix=$ZEL/tools					\
	--syslibdir=$ZEL/tools/lib				\
	--target=x86_64-zel-linux-musl				\
	--build=x86_64-zel-linux-musl				\
	--enable-shared						\
	--enable-static


make -j12


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make  install


#rm -rf $ZEL/tools/lib/ld-musl-x86_64.so.1
#ln -sv ./libc.so $ZEL/tools/lib/ld-musl-x86_64.so.1
mkdir $ZEL/tools/bin
ln -sv ../lib/libc.so $ZEL/tools/bin/ldd


cd ../../
rm -rf musl-1.2.2
