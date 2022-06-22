#!/bin/bash
#name="tcl"
#version"8.6.12"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://prdownloads.sourceforge.net/tcl/tcl8.6.12-src.tar.gz"
#}
#depend{
#	"zlib"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0012-tcl.log
tar -xf src/tcl8.6.12-src.tar.gz
cd tcl8.6.12


SRCDIR=$(pwd)
cd unix
mkdir build
cd build

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
../configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--enable-64bit

time make -j24
sed	-e "s|$SRCDIR/unix|/usr/lib|"		\
	-e "s|$SRCDIR|/usr/include|"		\
	-i tclConfig.sh
sed	-e "s|$SRCDIR/unix/pkgs/tdbc1.1.3|/usr/lib/tdbc1.1.3|"		\
	-e "s|$SRCDIR/pkgs/tdbc1.1.3/generic|/usr/include|"		\
	-e "s|$SRCDIR/pkgs/tdbc1.1.3/library|/usr/lib/tcl8.6|"		\
	-e "s|$SRCDIR/pkgs/tdbc1.1.3|/usr/include|"			\
	-i pkgs/tdbc1.1.3/tdbcConfig.sh
sed	-e "s|$SRCDIR/unix/pkgs/itcl4.2.2|/usr/lib/itcl4.2.2|"		\
	-e "s|$SRCDIR/pkgs/itcl4.2.2/generic|/usr/include|"		\
	-e "s|$SRCDIR/pkgs/itcl4.2.2|/usr/include|"			\
	-i pkgs/itcl4.2.2/itclConfig.sh
unset SRCDIR


time make test -j12 | tee ../../../logs/0012-tcl.log


time make install
time make install-private-headers
ln -sfv tclsh8.6 /usr/bin/tclsh


cd ../../../
rm -rf tcl8.6.12
