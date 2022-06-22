#!/bin/bash
#name="ninja"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O ninja-1.10.2.tar.gz https://github.com/ninja-build/ninja/archive/refs/tags/v1.10.2.tar.gz"
#}
#depend{
#	"Python3-minimal"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

touch logs/0063-ninja.log
tar -xf src/ninja-1.10.2.tar.gz
cd ninja-1.10.2


export NINJAJOBS=16
sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
python3 configure.py --bootstrap


./ninja ninja_test
./ninja_test --gtest_filter=-SubprocessTest.SetWithLots | tee ../logs/0063-ninja.log



install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja



cd ../
rm -rf ninja-1.10.2
