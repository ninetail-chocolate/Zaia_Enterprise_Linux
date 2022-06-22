#!/bin/bash
#name="pipewire"
#version="0.3.48"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"wget -O pipewire-0.3.48.tar.gz https://github.com/PipeWire/pipewire/archive/refs/tags/0.3.48.tar.gz"
#	"https://git.alpinelinux.org/aports/plain/community/pipewire/pipewire-launcher.sh"
#	"https://git.alpinelinux.org/aports/plain/community/pipewire/pipewire.desktop"
#	"https://git.alpinelinux.org/aports/plain/community/pipewire/0001-Revert-pulse-tunnel-use-format-channels-and-rate-pro.patch"
#}
#depend{
#	"ffmpeg"
#	"libva"
#	"git"
#	"vulkan-headers"
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
tar -xf src/pipewire-0.3.48.tar.gz
cd pipewire-0.3.48


patch -Np1 -i ../src/0001-Revert-pulse-tunnel-use-format-channels-and-rate-pro.patch
mkdir build
cd build


CC=clang					\
CXX=clang++					\
CFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld"		\
meson						\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--libdir=lib				\
	--localstatedir=/var			\
	--buildtype=release			\
	-Ddocs="disabled"			\
	-Dsession-managers="media-session"	\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


ninja install
install -Dm644 ../../src/pipewire.desktop -t /etc/xdg/autostart/
install -Dm755 ../../src/pipewire-launcher.sh /usr/libexec/pipewire-launcher


cd ../../
rm -rf pipewire-0.3.48
