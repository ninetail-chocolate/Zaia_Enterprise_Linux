#!/bin/bash
#name="git"
#version="2.35.1"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.35.1.tar.xz"
#}
#depend{
#	"curl"
#	"pcre"
#	"pcre2"
#	"python3"
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
tar -xf src/git-2.35.1.tar.xz
cd git-2.35.1


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--with-gitconfig=/etc/gitconfig		\
	--with-python=python3


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf git-2.35.1
