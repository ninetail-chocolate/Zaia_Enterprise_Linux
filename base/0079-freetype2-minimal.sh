#!/bin/bash
#name="freetype2"
#version"2.11.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://downloads.sourceforge.net/freetype/freetype-2.11.1.tar.xz"
#
#}
#depend{
#	"libpng"
#	"which"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0075-libxslt.log
tar -xf src/freetype-2.11.1.tar.xz
cd freetype-2.11.1


sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg
sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	--enable-freetype-config			\
	--without-harfbuzz


make -j24



#make check | tee ../../logs/0075-libxslt.log


make install


cd ../../
rm -rf freetype-2.11.1
