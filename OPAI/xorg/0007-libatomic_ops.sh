#!/bin/bash
#name="libatomic_ops"
#version"7.6.12"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/ivmai/libatomic_ops/releases/download/v7.6.12/libatomic_ops-7.6.12.tar.gz"
#}
#depend{
#	"musl"
#}
#groupdepend{
#		""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile.d/xorg.sh

tar -xf src/libatomic_ops-7.6.12.tar.gz
cd libatomic_ops-7.6.12


mkdir build
cd build

../configure						\
	CC=clang					\
	CXX=clang++					\
	CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
	--prefix=/usr					\
	--enable-shared					\
	--disable-static				\


make -j32


#make check -j32 | tee ../logs/0012-xcb-util-wm.log


make install


cd ../../
rm -rf libatomic_ops-7.6.12
