#!/bin/bash
#name="llvm-project"
#version"13.0.1"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/llvm-project-13.0.1.src.tar.xz"
#}
#depend{
#	"libffi"
#	"zlib"
#	"python3"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"
#tar -xf src/llvm-13.0.1.src.tar.xz
#cd llvm-13.0.1.src

tar -xf src/llvm-project-13.0.1.src.tar.xz
cd llvm-project-13.0.1.src


cd llvm
mkdir build
cd build

export NINJAJOBS=16

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CXX=clang++				\
cmake												\
-DCMAKE_CXX_FLAGS="-march=znver1 --target="x86_64-zel-linux-musl" -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" -fPIC"				\
-DCMAKE_C_FLAGS="-march=znver1 --target="x86_64-zel-linux-musl" -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" -fPIC"				\
-DLLVM_TABLEGEN="/usr/bin/llvm-tblgen"					\
-DCLANG_TABLEGEN="/usr/bin/clang-tblgen"				\
-DLLVM_CONFIG_PATH="/usr/bin/llvm-config"				\
-DLLVM_ENABLE_LLD="ON"										\
-DLLVM_INSTALL_BINUTILS_SYMLINKS="OFF"								\
-DLLVM_INSTALL_CCTOOLS_SYMLINKS="OFF"								\
-DLLVM_ENABLE_PROJECTS="libcxx;libcxxabi;libunwind;clang;clang-tools-extra;compiler-rt;lld;lldb"	\
-DCMAKE_INSTALL_PREFIX="/usr"								\
-DLLVM_ENABLE_FFI="ON"										\
-DCMAKE_BUILD_TYPE="Release"									\
-DLLVM_BUILD_LLVM_DYLIB="ON"									\
-DLLVM_LINK_LLVM_DYLIB="ON"									\
-DLLVM_ENABLE_RTTI="ON"										\
-DLLVM_TARGETS_TO_BUILD="host;BPF;AMDGPU"							\
-DLLVM_BUILD_TESTS="OFF"									\
-DLLVM_BINUTILS_INCDIR="/usr/include"							\
-Wno-dev											\
-G Ninja											\
-DLLVM_HOST_TRIPLE="x86_64-zel-linux-musl"							\
-DTARGET_TRIPLE="x86_64-zel-linux-musl"								\
-DLLVM_DEFAULT_TARGET_TRIPLE="x86_64-zel-linux-musl"						\
-DCOMPILER_RT_DEFAULT_TARGET_TRIPLE="x86_64-zel-linux-musl"			\
-DCLANG_DEFAULT_RTLIB="compiler-rt"								\
-DCLANG_DEFAULT_UNWINDLIB="libunwind"								\
-DCLANG_DEFAULT_LINKER="lld"									\
-DCLANG_LINK_CLANG_DYLIB="ON"									\
-DLLVM_COMPILER_IS_GCC_COMPATIBLE="ON"								\
-DLLVM_ENABLE_LIBXML2="ON"									\
-DCLANG_DEFAULT_CXX_STDLIB="libc++"								\
-DLIBUNWIND_ENABLE_STATIC="ON"									\
-DLIBCXXABI_ENABLE_STATIC="ON"									\
-DLIBCXX_ENABLE_STATIC="ON"									\
-DLIBUNWIND_ENABLE_SHARED="ON"									\
-DLIBCXXABI_ENABLE_SHARED="ON"									\
-DLIBCXX_ENABLE_SHARED="ON"									\
-DLIBCXX_USE_COMPILER_RT="ON"									\
-DLIBCXXABI_USE_COMPILER_RT="ON"								\
-DLIBCXXABI_USE_LLVM_UNWINDER="ON"								\
-DLIBUNWIND_USE_COMPILER_RT="ON"								\
-DLLVM_ENABLE_TERMINFO="OFF"									\
-DLLVM_ENABLE_BACKTRACES="OFF"									\
-DLLVM_ENABLE_ZLIB="ON"				\
-DLLVM_CCACHE_BUILD="OFF"					\
-DLLVM_ENABLE_LIBEDIT="OFF"									\
-DLLVM_ENABLE_LIBPFM="OFF"									\
-DLIBCXX_HAS_MUSL_LIBC="ON"					\
-DHAVE_POSIX_REGEX="0"									\
-DHAVE_STEADY_CLOCK="0"									\
-DCOMPILER_RT_HAS_GWP_ASAN="ON"								\
-DCOMPILER_RT_INCLUDE_TESTS="ON"							\
-DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON				\
-DCOMPILER_RT_BUILD_SANITIZERS=OFF				\
-DCOMPILER_RT_BUILD_XRAY=OFF					\
-DCOMPILER_RT_BUILD_PROFILE=OFF					\
-DCOMPILER_RT_BUILD_LIBFUZZER=OFF				\
-DCOMPILER_RT_CAN_EXECUTE_TESTS=OFF				\
-DCOMPILER_RT_HWASAN_WITH_INTERCEPTORS=OFF			\
-DBacktrace_LIBRARY=/lib/libexecinfo.so		\
-DBacktrace_INCLUDE_DIR=/usr/include					\
-DLLVM_DYLIB_COMPONENTS=all			\
-DLLVM_BUILD_LLVM_DYLIB_default="ON"		\
-DLLVM_ENABLE_PIC="ON"				\
../


time ninja 



#mkdir DEST
#DESTDIR=./DEST ninja install

time ninja install
ln -svf clang /usr/bin/cc
ln -svf clang++ /usr/bin/c++
ln -svf clang++ /usr/bin/g++
ln -svf clang-cpp /usr/bin/cpp
cp -Rv  bin/clang-tblgen /usr/bin/


cd ../../../
rm -rf llvm-project-13.0.1.src
