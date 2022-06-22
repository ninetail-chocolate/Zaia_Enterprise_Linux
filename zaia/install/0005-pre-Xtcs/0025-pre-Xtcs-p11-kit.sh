#!/bin/bash
#name="pre-Xtcs-p11-kit"
#version"0.24.1"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/p11-glue/p11-kit/releases/download/0.24.1/p11-kit-0.24.1.tar.xz"
#}
#depend{
#	"pre-Xtcs-libtasn1"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/p11-kit-0.24.1.tar.xz
cd p11-kit-0.24.1


sed '20,$ d' -i trust/trust-extract-compat &&
cat >> trust/trust-extract-compat << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Update trust stores
/usr/sbin/make-ca -r
EOF


mkdir bld
cd bld

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -isystem="$ZEL" "			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" --sysroot="$ZEL" -isystem="$ZEL" "			\
../configure				\
	--prefix=/usr			\
	--bindir=/usr/bin		\
	--sbindir=/usr/sbin		\
	--sysconfdir=/etc		\
	--mandir=/usr/share/man		\
	--infodir=/usr/share/info	\
	--localstatedir=/var		\
	--host=x86_64-zel-linux-musl	\
	--build=x86_64-zel-linux-musl	\
	--enable-shared			\
	--disable-static		\
	--with-trust-paths=/etc/pki/anchors	\
	--without-libffi			\
	--disable-debug				\
	--without-systemd


make -j24


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install
make DESTDIR=$ZEL install
ln -sfv /usr/libexec/p11-kit/trust-extract-compat	\
	$ZEL/usr/bin/update-ca-certificates

cd ../../
rm -rf p11-kit-0.24.1
