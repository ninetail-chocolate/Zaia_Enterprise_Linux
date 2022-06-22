#!/bin/bash
#name="meson"
#version"0.59.1"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/mesonbuild/meson/releases/download/0.59.1/meson-0.59.1.tar.gz"
#}
#depend{
#	"Python3-minimal"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

#touch logs/0063-ninja.log
tar -xf src/meson-0.59.1.tar.gz
cd meson-0.59.1


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
python3 setup.py build


python3 setup.py install --root=dest
cp -rv dest/* /
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson


cd ../
rm -rf meson-0.59.1
