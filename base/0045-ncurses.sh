#!/bin/bash
#name="ncurses"
#version"6.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://ftp.jaist.ac.jp/pub/GNU/ncurses/ncurses-6.3.tar.gz"
#
#}
#depend{
#	"cracklib"
#	"Linux-PAM"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0018-shadow.log
tar -xf src/ncurses-6.3.tar.gz
cd ncurses-6.3


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
./configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--prefix=/usr        		   		\
	--mandir=/usr/share/man 			\
	--with-pkg-config-libdir=/usr/lib/pkgconfig	\
	--with-shared           			\
	--without-debug         			\
	--without-normal				\
	--enable-pc-files       			\
	--with-versioned-syms				\
	--enable-widec

make -j24


make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libncursesw.so.6.3 /usr/lib
rm -v  dest/usr/lib/{libncursesw.so.6.3,libncurses++w.a}
cp -av dest/* /
for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done
rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so



cd ../
rm -rf ncurses-6.3
