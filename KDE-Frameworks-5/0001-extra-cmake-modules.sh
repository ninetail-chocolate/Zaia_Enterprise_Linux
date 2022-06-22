#!/bin/bash
#name="extra-cmake-modules"
#version="5.92.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://download.kde.org/stable/frameworks/5.92/extra-cmake-modules-5.92.0.tar.xz"
#}
#depend{
#	"cmake"
#	"ninja"
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

touch logs/0019-jasper.log
tar -xf src/extra-cmake-modules-5.92.0.tar.xz
cd extra-cmake-modules-5.92.0


sed 's/10)/11)/' -i find-modules/FindPythonModuleGeneration.cmake
sed -i '/"lib64"/s/64//' kde-modules/KDEInstallDirs.cmake
sed -e '/PACKAGE_INIT/i set(SAVE_PACKAGE_PREFIX_DIR "${PACKAGE_PREFIX_DIR}")' \
    -e '/^include/a set(PACKAGE_PREFIX_DIR "${SAVE_PACKAGE_PREFIX_DIR}")' \
    -i ECMConfig.cmake.in
mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
cmake						\
	-DCMAKE_INSTALL_PREFIX=/usr		\
	-DCMAKE_BUILD_TYPE=RELEASE		\
	-Wno-dev				\
	../

make


#ninja test | tee ../../logs/0019-jasper.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf extra-cmake-modules-5.92.0
