#!/bin/bash
#name="curl"
#version"7.81.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://curl.se/download/curl-7.81.0.tar.xz"
#
#}
#depend{
#	"make-ca"
#	"OpenSSL"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0080-curl.log
tar -xf src/curl-7.81.0.tar.xz
cd curl-7.81.0


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
	--with-openssl					\
	--enable-threaded-resolver			\
	--with-ca-path=/etc/ssl/certs

make -j24



#make test  | tee ../../logs/0084-curl.log


make install


cd ../../
rm -rf curl-7.81.0
