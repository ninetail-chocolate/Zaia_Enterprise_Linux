#!/bin/bash
#name="vim"
#version="8.2.4620"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"wget -O vim-8.2.4620.tar.gz https://github.com/vim/vim/archive/refs/tags/v8.2.4620.tar.gz"
#}
#depend{
#	"curl"
#	"pcre"
#	"pcre2"
#	"musl"
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


#touch logs/0038-libvpx.log
tar -xf src/vim-8.2.4620.tar.gz
cd vim-8.2.4620


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--disable-static			\
	--enable-shared


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf vim-8.2.4620
