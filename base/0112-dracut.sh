#!/bin/bash
#name="dracut"
#version"055"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/dracutdevs/dracut/releases/download/055/dracut-055.tar.xz"
#}
#depend{
#	"musl"
#	"cpio"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/dracut-055.tar.xz
cd dracut-055


./configure				\
CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--bashcompletiondir=/usr/share/bash-completion/completions	\
	--enable-dracut-cpio=yes

make -j32


#make check -j32


make install
#########################
echo "add custom settings"
cp -rvf ../src/base.conf /etc/dracut.conf.d/
cp -rvf ../src/polaris.conf /etc/dracut.conf.d/
echo "END custom settings"


cd ../
rm -rf dracut-055
