#!/bin/bash
#name="otcs-llvm-projects"
#version"14.0.0"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/llvm-project-14.0.0.src.tar.xz"
#}
#depend{
#	"otcs-libexecinfo"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/llvm-project-14.0.0.src.tar.xz
cd llvm-project-14.0.0.src


cd llvm
mkdir build
cd build

export NINJAJOBS=32

AR=llvm-ar				\
RANLIB=llvm-ranlib			\
CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" -L$ZEL/tools/lib -D_LIBCPP_HAS_MUSL_LIBC"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib="compiler-rt" -unwindlib="libunwind" -L$ZEL/tools/lib -D_LIBCPP_HAS_MUSL_LIBC"			\
cmake												\
-DCMAKE_SYSTEM_NAME="Linux"									\
-DLLVM_ENABLE_LLD="ON"										\
-DLLVM_INSTALL_BINUTILS_SYMLINKS="OFF"								\
-DLLVM_INSTALL_CCTOOLS_SYMLINKS="OFF"								\
-DLLVM_ENABLE_PROJECTS="clang;compiler-rt;libcxx;libcxxabi;libunwind;pstl"			\
-DDEFAULT_SYSROOT="$ZEL/tools"									\
-DCMAKE_INSTALL_PREFIX="$ZEL/tools"								\
-DLLVM_ENABLE_FFI="OFF"										\
-DCMAKE_BUILD_TYPE="Release"									\
-DLLVM_BUILD_LLVM_DYLIB="ON"									\
-DLLVM_LINK_LLVM_DYLIB="ON"									\
-DLLVM_ENABLE_RTTI="ON"										\
-DLLVM_TARGETS_TO_BUILD="host"									\
-DLLVM_BUILD_TESTS="OFF"									\
-DLLVM_BINUTILS_INCDIR="/usr/include"								\
-Wno-dev											\
-G Ninja											\
-DLLVM_HOST_TRIPLE="x86_64-zel-linux-musl"							\
-DTARGET_TRIPLE="x86_64-zel-linux-musl"								\
-DLLVM_DEFAULT_TARGET_TRIPLE="x86_64-zel-linux-musl"						\
-DCOMPILER_RT_DEFAULT_TARGET_TRIPLE="x86_64-zel-linux-musl"					\
-DCLANG_DEFAULT_RTLIB="compiler-rt"								\
-DCLANG_DEFAULT_UNWINDLIB="libunwind"								\
-DCLANG_DEFAULT_LINKER="lld"									\
-DLLVM_COMPILER_IS_GCC_COMPATIBLE="OFF"								\
-DLLVM_ENABLE_LIBXML2="OFF"									\
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
-DLLVM_ENABLE_ZLIB="OFF"									\
-DLLVM_CCACHE_BUILD="OFF"					\
-DLLVM_ENABLE_LIBEDIT="OFF"									\
-DLLVM_ENABLE_LIBPFM="OFF"									\
-DLLDB_ENABLE_PYTHON="OFF"									\
-DHAVE_POSIX_REGEX="0"										\
-DHAVE_STEADY_CLOCK="0"										\
-DCOMPILER_RT_USE_BUILTINS_LIBRARY="ON"								\
-DCOMPILER_RT_USE_BUILTINS_LIBRARY="ON"								\
-DCOMPILER_RT_BUILD_SANITIZERS="OFF"								\
-DCOMPILER_RT_BUILD_XRAY="OFF"									\
-DCOMPILER_RT_BUILD_PROFILE="OFF"								\
-DCOMPILER_RT_BUILD_LIBFUZZER="OFF"								\
-DCOMPILER_RT_CAN_EXECUTE_TESTS="OFF"								\
-DCOMPILER_RT_HWASAN_WITH_INTERCEPTORS="OFF"							\
-DBacktrace_LIBRARY=$ZEL/tools/lib/libexecinfo.so						\
-DBacktrace_INCLUDE_DIR=$ZEL/tools/include							\
-DCMAKE_CXX_COMPILER_TARGET="x86_64-zel-linux-musl"					\
-DCOMPILER_RT_BUILD_STANDALONE_LIBATOMIC="ON"						\
-DLLVM_ENABLE_PIC="ON"									\
-DLIBCXX_ENABLE_THREADS="ON"								\
-DLIBCLANG_BUILD_STATIC="ON"								\
../


ninja -j32


#mkdir DEST
#DESTDIR=./DEST ninja install
ninja install
cp -Rv  bin/clang-tblgen $ZEL/tools/bin/


cd ../../../
rm -rf llvm-project-14.0.0.src
