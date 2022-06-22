#!/bin/bash
#name="firefox"
#version="91.7.1-ESR"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://archive.mozilla.org/pub/firefox/releases/91.7.1esr/source/firefox-91.7.1esr.source.tar.xz"
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

tar -xf src/firefox-91.7.1esr.source.tar.xz
cd firefox-91.7.1


cat > mozconfig << "EOF"
# If you have a multicore machine, all cores will be used by default.

# If you have installed (or will install) wireless-tools, and you wish
# to use geolocation web services, comment out this line
#ac_add_options --disable-necko-wifi

# API Keys for geolocation APIs - necko-wifi (above) is required for MLS
# Uncomment the following line if you wish to use Mozilla Location Service
#ac_add_options --with-mozilla-api-keyfile=$PWD/mozilla-key

# Uncomment the following line if you wish to use Google's geolocaton API
# (needed for use with saved maps with Google Maps)
#ac_add_options --with-google-location-service-api-keyfile=$PWD/google-key

# startup-notification is required since firefox-78

# Uncomment the following option if you have not installed PulseAudio
#ac_add_options --disable-pulseaudio
# or uncomment this if you installed alsa-lib instead of PulseAudio
#ac_add_options --enable-alsa

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --with-system-icu
ac_add_options --with-system-libevent
ac_add_options --with-system-libvpx
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-webp

# Do not specify the gold linker which is not the default. It will take
# longer and use more disk space when debug symbols are disabled.

# libdavid (av1 decoder) requires nasm. Uncomment this if nasm
# has not been installed.
#ac_add_options --disable-av1

# You cannot distribute the binary if you do this
ac_add_options --enable-official-branding

# Stripping is now enabled by default.
# Uncomment these lines if you need to run a debugger:
#ac_add_options --disable-strip
#ac_add_options --disable-install-strip

# Disabling debug symbols makes the build much smaller and a little
# faster. Comment this if you need to run a debugger. Note: This is
# required for compilation on i686.
ac_add_options --disable-debug-symbols

# The elf-hack is reported to cause failed installs (after successful builds)
# on some machines. It is supposed to improve startup time and it shrinks
# libxul.so by a few MB - comment this if you know your machine is not affected.
ac_add_options --disable-elf-hack

# The BLFS editors recommend not changing anything below this line:
ac_add_options --prefix=/usr
ac_add_options --enable-application=browser
ac_add_options --disable-crashreporter
ac_add_options --disable-updater
# enabling the tests will use a lot more space and significantly
# increase the build time, for no obvious benefit.
ac_add_options --disable-tests

# The default level of optimization again produces a working build with gcc.
#ac_add_options --enable-optimize

ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

ac_add_options --with-system-jpeg
ac_add_options --with-system-png
ac_add_options --with-system-zlib

##
ac_add_options --target=x86_64-unknown-linux-musl
ac_add_options --host=x86_64-unknown-linux-musl
ac_add_options --disable-jemalloc
ac_add_options --disable-profiling
###

# The following option unsets Telemetry Reporting. With the Addons Fiasco,
# Mozilla was found to be collecting user's data, including saved passwords and
# web form data, without users consent. Mozilla was also found shipping updates
# to systems without the user's knowledge or permission.
# As a result of this, use the following command to permanently disable
# telemetry reporting in Firefox.
unset MOZ_TELEMETRY_REPORTING

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF


export CC=clang CXX=clang++
#export CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"
#export CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"
export MACH_USE_SYSTEM_PYTHON=1
export MOZBUILD_STATE_PATH=${PWD}/mozbuild
./mach configure


./mach build


#make install

unset CC CXX CFLAGS CXXFLAGS MACH_USE_SYSTEM_PYTHON MOZBUILD_STATE_PATH

cd ../
#rm -rf firefox-91.7.1
