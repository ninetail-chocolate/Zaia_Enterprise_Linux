#!/bin/bash
#name="graphite2"
#version"1.3.14"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz"
#	"https://git.alpinelinux.org/aports/plain/main/graphite2/cmake.patch"
#
#}
#depend{
#	"freetype2"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#patch -Np1 -i ../src/cmake.patch
#touch logs/0085-libarchive.log
tar -xf src/graphite2-1.3.14.tgz
cd graphite2-1.3.14

rm -rvf src/CMakeLists.txt 
cp -rvf ../src/CMakeLists.txt src/CMakeLists.txt
mkdir build
cd build


CC=clang					\
CXX=clang++					\
cmake						\
	-DCMAKE_SYSTEM_NAME="Linux"		\
	-DCMAKE_CXX_COMPILER_ID="Clang"		\
	-DCMAKE_CXX_FLAGS="-march=znver1 --target="x86_64-zel-linux-musl" -fPIC --stdlib=libc++ -rtlib=compiler-rt -unwindlib="libunwind" "	\
	-DCMAKE_C_FLAGS="-march=znver1 --target="x86_64-zel-linux-musl" --stdlib=libc++ -rtlib=compiler-rt -fPIC -unwindlib="libunwind""	\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE="Release"		\
	-G Ninja				\
../


ninja -j24


#make check  | tee ../../logs/0085-libarchive.log


ninja install


cd ../../
rm -rf graphite2-1.3.14
