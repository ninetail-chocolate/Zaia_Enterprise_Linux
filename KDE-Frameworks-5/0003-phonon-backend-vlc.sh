#!/bin/bash
#name="phonon-backend-vlc"
#version="0.11.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.kde.org/stable/phonon/phonon-backend-vlc/0.11.3/phonon-backend-vlc-0.11.3.tar.xz"
#}
#depend{
#	"cmake"
#	"ninja"
#	"phonon"
#	"vlc"
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

#touch logs/0002-phonon.log
tar -xf src/phonon-backend-vlc-0.11.3.tar.xz
cd phonon-backend-vlc-0.11.3


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_INSTALL_LIBDIR=lib		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#ninja test | tee ../../logs/0002-phonon.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install


cd ../../
rm -rf phonon-backend-vlc-0.11.3
