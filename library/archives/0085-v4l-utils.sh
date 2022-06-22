#!/bin/bash
#name="v4l-utils"
#version="1.22.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.22.1.tar.bz2"
#	"wget -O v4l-libcxx.patch  https://patches.linaro.org/project/linux-media/patch/20200429040627.27859-5-rosenp@gmail.com/raw/"
#}
#depend{
#	"eudev"
#	"alsa-lib"
#	"glu"
#	"libjpeg-turbo"
#	"Qt5"
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
tar -xf src/v4l-utils-1.22.1.tar.bz2
cd v4l-utils-1.22.1

patch -Np1 -i ../src/v4l-libcxx.patch
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


#make install


cd ../../
rm -rf v4l-utils-1.22.1
