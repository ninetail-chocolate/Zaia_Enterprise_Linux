#!/bin/bash
#name="rtkit"
#version="0.13"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/heftig/rtkit/releases/download/v0.13/rtkit-0.13.tar.xz"
#	"https://git.alpinelinux.org/aports/plain/community/rtkit/50-rtkit.rules"
#	"https://git.alpinelinux.org/aports/plain/community/rtkit/rtkit.confd"
#	"https://git.alpinelinux.org/aports/plain/community/rtkit/rtkit.initd"
#	"https://git.alpinelinux.org/aports/plain/community/rtkit/sched_getscheduler_sched_setscheduler.patch"
#}
#depend{
#	"dbus"
#	"libcap"
#	"meson"
#	"zlib"
#	"vim"
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
tar -xf src/rtkit-0.13.tar.xz
cd rtkit-0.13


patch -Np1 -i ../src/sched_getscheduler_sched_setscheduler.patch
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
	-Dlibsystemd=disabled			\
	-Dinstalled_tests=false			\
	../


ninja


#make test -j32 | tee ../../logs/0038-libvpx.log

#mkdir DEST
#make DESTDIR=$(pwd)/DEST install



groupadd -g 133 rtkit
useradd -c RealtimeKit -d /proc -g rtkit -s /bin/false -u 133 rtkit
ninja install
install -Dm755 ../../src/rtkit.initd /etc/init.d/rtkit
install -Dm644 ../../src//rtkit.confd /etc/conf.d/rtkit
install -Dm644 ../../src/50-rtkit.rules /usr/share/polkit-1/rules.d/50-rtkit.rules


cd ../../
rm -rf rtkit-0.13
