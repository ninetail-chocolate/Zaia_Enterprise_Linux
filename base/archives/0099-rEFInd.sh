#!/bin/bash
#name="gnu-efi"
#version""
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://sourceforge.net/projects/refind/files/0.13.2/refind-src-0.13.2.tar.gz"
#	"https://git.alpinelinux.org/aports/plain/testing/refind/gnu-efi-3014.patch"
#	"https://git.alpinelinux.org/aports/plain/testing/refind/01-missing-always-inline.patch"
#}
#depend{
#	"gnu-efi"
#	"efibootmgr"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0006-zstd.log
tar -xf src/refind-src-0.13.2.tar.gz
cd refind-0.13.2
patch -Np1 -i ../src/gnu-efi-3014.patch
patch -Np1 -i ../src/01-missing-always-inline.patch
sed -e 's|RefindDir=\"\$ThisDir/refind\"|RefindDir="/usr/share/refind/"|g' \
			-i refind-install
sed -i 's/-fno-tree-loop-distribute-patterns//g' Make.common
#cat filesystems/crc32c.c | sed '22i #include <stdint.h>' > filesystems/crc32c.c



CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"	\
make CC=clang
CC=clang                                \
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC --target=x86_64-zel-linux-musl"        \
make CC=clang  gptsync




install -vDm 644 refind/*.efi -t /usr/share/refind
install -vDm 644 gptsync/*.efi -t /usr/share/refind/tools_x86_64
install -vDm 644 refind.conf-sample -t /usr/share/refind
install -vDm 644 keys/*{cer,crt} -t /usr/share/refind/keys
install -vdm 700 /etc/refind.d/keys
install -vDm 644 fonts/*.png -t /usr/share/refind/fonts
install -vDm 644 icons/*.png -t /usr/share/refind/icons
install -vDm 644 icons/svg/*.svg -t /usr/share/refind/icons/svg
install -vDm 755 {refind-install,mkrlconf,mvrefind} -t /usr/bin
install -vDm 755 fonts/mkfont.sh /usr/bin/refind-mkfont
install -vDm 644 docs/man/*.8 -t /usr/share/man/man8


#make PREFIX=/usr INSTALLROOT=/ install


cd ../
rm -rf refind-0.13.2
