#!/bin/bash
#name="automake"
#version"1.2.7"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O musl-fts-1.2.7.tar.gz https://github.com/pullmoll/musl-fts/archive/refs/tags/v1.2.7.tar.gz"
#
#}
#depend{
#	"autoconf"
#	"automake"
#	"libtool-GNU"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0038-musl-fts.log
tar -xf src/musl-fts-1.2.7.tar.gz
cd musl-fts-1.2.7
#cat > bootstrap.sh <<EOF
#!/bin/sh
#libtoolize-GNU
#aclocal
#autoconf
#autoheader
#automake --add-missing
#EOF

chmod a+x bootstrap.sh
./bootstrap.sh



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
	--sysconfdir=/etc			\
	--localstatedir=/var


make check -j24 | tee ../../logs/0038-musl-fts.log


make install -j24


cd ../../
rm -rf musl-fts-1.2.7
