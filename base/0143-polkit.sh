#!/bin/bash
#name="polkit"
#version"0.120"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.freedesktop.org/software/polkit/releases/polkit-0.120.tar.gz"
#	"https://gitweb.gentoo.org/repo/gentoo.git/plain/sys-auth/polkit/files/polkit-0.118-make-netgroup-support-optional.patch"
#}
#depend{
#	"glib"
#	"js78"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/polkit-0.120.tar.gz
cd polkit-0.120


patch -Np1 -i ../src/polkit-0.118-make-netgroup-support-optional.patch

sed '/0,/s/^/#/' -i meson_post_install.py &&
sed '/policy,/d' -i actions/meson.build \
                 -i src/examples/meson.build

mkdir build
cd build

CC=clang				\
CXX=clang++				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC  -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"		\
meson					\
	--prefix=/usr			\
	-Dman=false			\
	-Dsession_tracking=libelogind	\
	-Dsystemdsystemunitdir=/tmp	\
	--buildtype=release		\
	-Dexamples=false		\
	-Dgtk_doc=false			\
	../



ninja



#make check -j32 | tee ../logs/0128-fontconfig.log



groupadd -fg 27 polkitd
useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 -g polkitd -s /bin/false polkitd
ninja install
rm -v /tmp/*.service
cat > /etc/pam.d/polkit-1 << "EOF"
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF




cd ../../
rm -rf polkit-0.120
