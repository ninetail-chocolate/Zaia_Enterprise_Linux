#!/bin/bash
#name="sudo"
#version"5.16"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://www.sudo.ws/dist/sudo-1.9.9.tar.gz"
#
#}
#depend{
#	"Linux-PAM"
#	"OpenLDAP"
#	"nano"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0144-lzo.log
tar -xf src/sudo-1.9.9.tar.gz
cd sudo-1.9.9


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
./configure					\
	--host=x86_64-zel-linux-musl		\
	--build=x86_64-zel-linux-musl		\
	--prefix=/usr				\
	--libexecdir=/usr/lib			\
	--with-secure-path			\
	--with-all-insults			\
	--with-editor=/usr/bin/nano		\
	--with-env-editor			\
	--with-passprompt="[sudo] password for %p: "


make -j32


#make -j32 check | tee ../../logs/0144-lzo.log


make install -j24
cat > /etc/sudoers.d/00-sudo << "EOF"
Defaults secure_path="/usr/sbin:/usr/bin"
%wheel ALL=(ALL) ALL
EOF
cat > /etc/pam.d/sudo << "EOF"
# Begin /etc/pam.d/sudo

# include the default auth settings
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/sudo
EOF
chmod 644 /etc/pam.d/sudo



cd ../
rm -rf sudo-1.9.9
