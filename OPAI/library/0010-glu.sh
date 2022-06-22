#!/bin/bash
#name="glu"
#version="9.0.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mesa3d.org//glu/glu-9.0.2.tar.xz"
#}
#depend{
#	"mesa"
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


touch logs/0010-glu.log
tar -xf src/glu-9.0.2.tar.xz
cd glu-9.0.2


mkdir build
cd build

CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	-Dgl_provider=gl			\
	--buildtype=release			\
	../

ninja


ninja test | tee ../../logs/0010-glu.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


ninja install
rm -vf /usr/lib/libGLU.a


cd ../../
rm -rf glu-9.0.2
