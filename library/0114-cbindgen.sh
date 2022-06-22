#!/bin/bash
#name="cbindgen"
#version="0.21"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"wget -O cbindgen-0.21.0.tar.gz https://github.com/eqrion/cbindgen/archive/refs/tags/v0.21.0.tar.gz"
#}
#depend{
#	"rustc"
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


#touch logs/0038-libvpx.log
tar -xf src/cbindgen-0.21.0.tar.gz
cd cbindgen-0.21.0


cargo build --release


install -Dm755 target/release/cbindgen /usr/bin/


cd ../
rm -rf cbindgen-0.21.0
