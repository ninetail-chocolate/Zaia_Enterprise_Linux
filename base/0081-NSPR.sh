#!/bin/bash
#name="NSPR"
#version"4.33"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mozilla.org/pub/nspr/releases/v4.33/src/nspr-4.33.tar.gz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0013-libffi.log
tar -xf src/nspr-4.33.tar.gz
cd nspr-4.33

cd nspr
sed -ri '/^RELEASE/s/^/#/' pr/src/misc/Makefile.in
sed -i 's#$(LIBRARY) ##'   config/rules.mk  
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--with-mozilla				\
	--with-pthreads				\
	--enable-64bit


make


make install


cd ../../../
rm -rf nspr-4.33
