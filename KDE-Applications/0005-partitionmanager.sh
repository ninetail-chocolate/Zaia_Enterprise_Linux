#!/bin/bash
#name="partitionmanager"
#version="21.12.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://download.kde.org/stable/release-service/21.12.3/src/partitionmanager-21.12.3.tar.xz"
#}
#depend{
#	"musl"
#}
#groupdepend{
#		"KDE-Plasma-5"
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
tar -xf src/partitionmanager-21.12.3.tar.xz
cd partitionmanager-21.12.3


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=$KF5_PREFIX	\
	-DCMAKE_PREFIX_PATH=$QT5DIR		\
	-DCMAKE_INSTALL_LIBDIR=lib		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-DBUILD_TESTING=OFF			\
	-Wno-dev				\
	-G Ninja				\
	../

ninja


#ninja test | tee ../../logs/0002-phonon.log


#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


#ninja install


cd ../../
rm -rf partitionmanager-21.12.3
