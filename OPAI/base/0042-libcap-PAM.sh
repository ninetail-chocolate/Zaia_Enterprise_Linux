#!/bin/bash
#name="libcap"
#version"2.63"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"http://ftp.iij.ad.jp/pub/linux/kernel/linux/libs/security/linux-privs/libcap2/libcap-2.63.tar.xz"
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


touch logs/0016-libcap.log
tar -xf src/libcap-2.63.tar.xz
cd libcap-2.63


CC=clang				\
CFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-v -march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
make CC=clang CXX=clang++  -C pam_cap -j24


#make test -j24 | tee ../logs/0016-libcap.log


install -v -m755 pam_cap/pam_cap.so /usr/lib/security
install -v -m644 pam_cap/capability.conf /etc/security
mv -v /etc/pam.d/system-auth{,.bak}
cat > /etc/pam.d/system-auth << "EOF"
# Begin /etc/pam.d/system-auth

auth      optional    pam_cap.so
EOF
tail -n +3 /etc/pam.d/system-auth.bak >> /etc/pam.d/system-auth



cd ../
rm -rf libcap-2.63
