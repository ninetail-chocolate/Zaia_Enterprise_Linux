#!/bin/bash
#name="libcap"
#version"2.63"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.iij.ad.jp/pub/linux/kernel/linux/libs/security/linux-privs/libcap2/libcap-2.63.tar.xz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

ln -svf clang /usr/bin/gcc
ln -svf clang++ /usr/bin/g++

touch logs/0016-libcap.log
tar -xf src/libcap-2.63.tar.xz
cd libcap-2.63


CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make prefix=/usr lib=lib -j24


make test -j24 | tee ../logs/0016-libcap.log


make prefix=/usr lib=lib install


rm -rf /usr/bin/gcc
rm -rf /usr/bin/g++
cd ../
rm -rf libcap-2.63
