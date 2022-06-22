#!/bin/bash
#name="zstd"
#version"1.0.8"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-1.5.2.tar.gz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0006-zstd.log
tar -xf src/zstd-1.5.2.tar.gz
cd zstd-1.5.2


CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make -j12


make check -j24 | tee ../logs/0006-zstd.log


make PREFIX=/usr install
rm -v /usr/lib/libzstd.a
sed -i -e 's/local//g' /usr/lib/pkgconfig/libzstd.pc


cd ../
rm -rf zstd-1.5.2
