#!/bin/bash
#name="cracklib"
#version"2.9.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/cracklib/cracklib/releases/download/v2.9.7/cracklib-2.9.7.tar.bz2"
#	"https://github.com/cracklib/cracklib/releases/download/v2.9.7/cracklib-words-2.9.7.bz2"
#
#}
#depend{
#	"zlib"
#	"gzip"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0017-cracklib.log
tar -xf src/cracklib-2.9.7.tar.bz2
cd cracklib-2.9.7


sed -i '/skipping/d' util/packer.c
sed -i '15209 s/.*/am_cv_python_version=3.10/' configure


mkdir build
cd build

CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl -I/usr/include/python3.10"			\
CXX=clang++			\
CXXFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl -I/usr/include/python3.10"			\
PYTHON=python3						\
../configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr					\
	--disable-static				\
	--with-default-dict=/usr/lib/cracklib/pw_dict


make -j24


make install -j24
install -v -m644 -D	../../src/cracklib-words-2.9.7.bz2 /usr/share/dict/cracklib-words.bz2
bunzip2 -v               /usr/share/dict/cracklib-words.bz2
ln -v -sf cracklib-words	/usr/share/dict/words
install -v -m755 -d      /usr/lib/cracklib
create-cracklib-dict     /usr/share/dict/cracklib-words


cd ../../
rm -rf cracklib-2.9.7
