#!/bin/bash
#name="alsa-utils"
#version="1.2.6"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.alsa-project.org/files/pub/utils/alsa-utils-1.2.6.tar.bz2"
#	"https://git.alpinelinux.org/aports/plain/main/alsa-utils/alsa.confd"
#	"https://git.alpinelinux.org/aports/plain/main/alsa-utils/alsa.initd"
#}
#depend{
#	"alsa-lib"
#	"xmlto"
#	"docbook-xml"
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

touch logs/0001-alsa-lib.log
tar -xf src/alsa-utils-1.2.6.tar.bz2
cd alsa-utils-1.2.6


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\
	--disable-bat					\
	--with-curses=ncursesw

make -j32


#make check -j32 | tee ../../logs/0001-alsa-lib.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make install
install -D -m755 ../../src/alsa.initd /etc/init.d/alsa
install -D -m644 ../../src/alsa.confd /etc/conf.d/alsa

#alsactl store

cd ../../
rm -rf alsa-utils-1.2.6
