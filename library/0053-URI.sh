#!/bin/bash
#name="URI"
#version="5.09"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.cpan.org/authors/id/O/OA/OALDERS/URI-5.09.tar.gz"
#}
#depend{
#	"perl"
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


source /etc/profile

#touch logs/0038-libvpx.log
tar -xf src/URI-5.09.tar.gz
cd URI-5.09


#mkdir build
#cd build


#CC=clang					\
#CXX=clang++					\
#CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
#CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
perl Makefile.PL


make -j12


#meson compile -j12 -C build
#ninja -j1


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf URI-5.09
