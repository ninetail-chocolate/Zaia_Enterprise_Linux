#!/bin/bash
#name="firefox"
#version="99.0"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mozilla.org/pub/firefox/releases/99.0/source/firefox-99.0.source.tar.xz"
#}
#depend{
#	"autoconf"
#	"cbindgen"
#	"dbus-glib"
#	"gtk3"
#	"libnotify"
#	"libpulse"
#	"alsa-lib"
#	"python3"
#	"sqlite"
#	"startup-notification"
#	"unzip"
#	"zip"
#	"yasm"
#	"zip"
#	"icu"
#	"libvpx"
#	"libwebp"
#	"nasm"
#	"nss"
#	"ffmpeg"
#	"curl"
#	"node-js"
#	"libevent"
#	"gyp"
#	"libXdamage"
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

tar -xf src/firefox-99.0.source.tar.xz
cd firefox-99.0


patch -Np1 -i ../src/avoid-redefinition.patch
patch -Np1 -i ../src/allow-custom-rust-vendor.patch
patch -Np1 -i ../src/rust-configure.patch
sed -i 's/\("files":{\)[^}]*/\1/' third_party/rust/audio_thread_priority/.cargo-checksum.json
sed -i 's/\("files":{\)[^}]*/\1/' third_party/rust/target-lexicon-0.9.0/.cargo-checksum.json


mkdir bld
cd bld


export CXXSTDLIB=c++
export CC="clang -stdlib=libc++"
export CXX="clang++ -stdlib=libc++"
export RUST_TARGET=x86_64-unknown-linux-musl
export MACH_USE_SYSTEM_PYTHON=1
export CXXFLAGS="-rtlib=compiler-rt -unwindlib=libunwind"
export LDFLAGS="$LDFLAGS -Wl,-rpath,/usr/lib/firefox,--enable-new-dtags"
export RUSTFLAGS="-Ctarget-feature=-crt-static -lc++"
export MOZBUILD_STATE_PATH=zel-firefox-config
../mach configure					\
	--prefix=/usr					\
	--disable-webrtc				\
	--disable-cargo-incremental			\
	--disable-crashreporter				\
	--disable-install-strip				\
	--disable-jemalloc				\
	--disable-profiling				\
	--disable-strip					\
	--disable-tests					\
	--disable-updater				\
	--enable-alsa					\
	--enable-dbus					\
	--enable-default-toolkit=cairo-gtk3-wayland	\
	--enable-ffmpeg					\
	--enable-hardening				\
	--enable-linker=lld				\
	--disable-necko-wifi				\
	--enable-pulseaudio				\
	--enable-release				\
	--enable-system-ffi				\
	--enable-system-pixman				\
	--with-system-ffi				\
	--with-system-icu				\
	--with-system-jpeg				\
	--with-system-libevent				\
	--with-system-libvpx				\
	--with-system-nspr				\
	--with-system-pixman				\
	--with-system-png				\
	--with-system-webp				\
	--with-system-zlib				\
	--with-unsigned-addon-scopes=app,system		\
	--target=x86_64-zel-linux-musl			\
	--host=x86_64-unknown-linux-musl		\
	--without-wasm-sandboxed-libraries		\
	--without-wasm-sandboxed-libraries		\
	--disable-elf-hack				\
	--enable-rust-simd				\
	--with-distribution-id=ZAIA-Enterprise-Linux


#	--with-libclang-path=/usr/lib
#	--with-system-nss

../mach build


#mkdir -pv DEST
#DESTDIR=$(pwd)/DEST ../mach install


DESTDIR=/ ../mach install
unset CC CXX CFLAGS CXXFLAGS MACH_USE_SYSTEM_PYTHON MOZBUILD_STATE_PATH RUSTFLAGS RUST_TARGET LDFLAGS CXXSTDLIB

cd ../../
rm -rf firefox-99.0
