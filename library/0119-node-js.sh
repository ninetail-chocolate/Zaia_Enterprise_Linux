#!/bin/bash
#name="node-js"
#version="17.8.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://nodejs.org/dist/v17.8.0/node-v17.8.0.tar.xz"
#}
#depend{
#	"which"
#	"libuv"
#	"icu"
#	"nghttp"
#	"c-ares"
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
tar -xf src/node-v17.8.0.tar.xz
cd node-v17.8.0


#mkdir build
#cd build


#from "https://test-import.gitlabproservices.com/gkoltsov/node7/-/issues/39546"
[ -r /usr/lib/libatomic.so ] || {
    sed 's/-latomic//' node.gyp > _ 
    mv -f _ node.gyp
}
#END

sed -i 's|ares_nameser.h|arpa/nameser.h|' src/cares_wrap.h


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--shared-cares				\
	--shared-libuv				\
	--shared-openssl			\
	--shared-nghttp2			\
	--shared-zlib				\
	--with-intl=system-icu

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../
rm -rf node-v17.8.0
