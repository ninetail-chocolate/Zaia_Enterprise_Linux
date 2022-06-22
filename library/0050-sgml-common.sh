#!/bin/bash
#name="sgml-common"
#version="0.6.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceware.org/ftp/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz"
#	"https://www.linuxfromscratch.org/patches/blfs/svn/sgml-common-0.6.3-manpage-1.patch"
#}
#depend{
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


source /etc/profile

#touch logs/0038-libvpx.log
tar -xf src/sgml-common-0.6.3.tgz
cd sgml-common-0.6.3


patch -Np1 -i ../src/sgml-common-0.6.3-manpage-1.patch
autoreconf -f -i


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
./configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--enable-shared				\
	--disable-static

make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make docdir=/usr/share/doc install
install-catalog --add /etc/sgml/sgml-ent.cat \
    /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
install-catalog --add /etc/sgml/sgml-docbook.cat \
    /etc/sgml/sgml-ent.cat


cd ../
rm -rf sgml-common-0.6.3
