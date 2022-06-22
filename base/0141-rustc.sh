#!/bin/bash
#name="rustc"
#version"1.59.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://static.rust-lang.org/dist/rustc-1.59.0-src.tar.gz"
#}
#depend{
#	"curl"
#	"cmake"
#	"libssh"
#	"llvm-project"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/rustc-1.59.0-src.tar.gz
cd rustc-1.59.0-src

patch -Np1 -i ../src/zel-target.patch
patch -Np1 -i ../src/1.56.1-musl-dynamic-linking.patch


cat << EOF > config.toml
# see config.toml.example for more possible options
# See the 8.4 book for an example using shipped LLVM
# e.g. if not installing clang, or using a version before 10.0
[llvm]
# by default, rust will build for a myriad of architectures
targets = "X86"

# When using system llvm prefer shared libraries
link-shared = true

[build]
# omit docs to save time and space (default is to build them)
docs = false
host = ["x86_64-unknown-linux-musl"]
target = ["x86_64-unknown-linux-musl"]
build = "x86_64-unknown-linux-musl"
# install cargo as well as rust
extended = true
python = "python3"

#vendor = true

[install]
prefix = "/usr"

[rust]
channel = "stable"
rpath = true

musl-root = "/usr"

use-lld = true


#parallel-compiler = false
llvm-libunwind = 'system'


# BLFS does not install the FileCheck executable from llvm,
# so disable codegen tests
codegen-tests = false

[target.x86_64-unknown-linux-musl]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"
cc = "/usr/bin/clang"
cxx = "/usr/bin/clang++"
musl-libdir = "/usr/lib"

# for musl build need it 
crt-static = false
# for musl build need it END

#[target.x86_64-unknown-linux-musl]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
#llvm-config = "/usr/bin/llvm-config"
#cc = "/usr/bin/clang"
#cxx = "/usr/bin/clang++"
#musl-libdir = "/usr/lib"
#
## for musl build need it
#crt-static = false
## for musl build need it END


EOF


export RUSTFLAGS=-Ctarget-feature=-crt-static
export PKG_CONFIG_ALLOW_CROSS=1
export RUSTFLAGS="$RUSTFLAGS -C link-args=-lffi"
python3 ./x.py build --exclude src/tools/miri --jobs 24
unset RUSTFLAGS
export LIBSSH2_SYS_USE_PKG_CONFIG=1
DESTDIR=${PWD}/install python3 ./x.py install --jobs 24
unset LIBSSH2_SYS_USE_PKG_CONFIG PKG_CONFIG_ALLOW_CROSS
chown -R root:root install


cp -a install/* /



cd ../
rm -rf rustc-1.59.0-src
