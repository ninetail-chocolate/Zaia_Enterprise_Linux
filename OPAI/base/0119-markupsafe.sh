#!/bin/bash
#name="markupsafe"
#version"2.1.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O markupsafe-2.1.0.tar.gz https://github.com/pallets/markupsafe/archive/refs/tags/2.1.0.tar.gz"
#}
#depend{
#	"python3"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/markupsafe-2.1.0.tar.gz
cd markupsafe-2.1.0


CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
python3	setup.py build


python3 setup.py install --optimize=1


cd ../
rm -rf markupsafe-2.1.0
