#!/bin/bash
#name="musl-obstack"
#version"1.2.2"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O musl-obstack-1.2.2.tar.gz https://github.com/void-linux/musl-obstack/archive/refs/tags/v1.2.2.tar.gz"
#
#}
#depend{
#	"libtool-GNU"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0058-intltool.log
tar -xf src/musl-obstack-1.2.2.tar.gz
cd musl-obstack-1.2.2
#cat > bootstrap.sh <<EOF
#!/bin/sh
#libtoolize-GNU
#aclocal
#autoheader
#autoconf
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
	--enable-shared				\
	--disable-static			\


make -j24

#mkdir -pv /usr/base/oppai/DT
#make DESTDIR=/usr/base/oppai/DT install
#make check -j1 | tee ../../logs/0058-intltool.log


make install -j24


cd ../../
rm -rf musl-obstack-1.2.2
