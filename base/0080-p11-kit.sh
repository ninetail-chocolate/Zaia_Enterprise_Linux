#!/bin/bash
#name="p11-kit"
#version"0.24.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/p11-glue/p11-kit/releases/download/0.24.1/p11-kit-0.24.1.tar.xz"
#}
#depend{
#	"libtasn1"
#	"meson"
#	"ninja"
#	"libxslt"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0013-libffi.log
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

CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
meson						\
	--prefix=/usr				\
	--buildtype=release			\
	-Dtrust_paths=/etc/pki/anchors

ninja


ninja install
ln -sfv /usr/libexec/p11-kit/trust-extract-compat /usr/bin/update-ca-certificates
ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so


cd ../../
rm -rf p11-kit-0.24.1
