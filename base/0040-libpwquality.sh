#!/bin/bash
#name="libpwquality"
#version"1.4.4"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://github.com/libpwquality/libpwquality/releases/download/libpwquality-1.4.4/libpwquality-1.4.4.tar.bz2"
#	"https://git.alpinelinux.org/aports/plain/community/libpwquality/0001-fix-musl-build.patch"
#
#}
#depend{
#	"cracklib"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


#touch logs/0022-libtirpc.log
tar -xf src/libpwquality-1.4.4.tar.bz2
cd libpwquality-1.4.4
patch -Np1 -i ../src/0001-fix-musl-build.patch


CC=clang				\
CFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
CXX=clang++			\
CXXFLAGS="-march=znver1 -O2 -pipe -fPIC -stdlib="libc++" -rtlib=compiler-rt -unwindlib="libunwind" -fuse-ld=lld --target=x86_64-zel-linux-musl"			\
./configure						\
	--host=x86_64-zel-linux-musl			\
	--build=x86_64-zel-linux-musl			\
	--disable-static				\
	--prefix=/usr					\
	--enable-pam					\
	--with-securedir=/usr/lib/security		\
	--with-python-binary=python3


make -j24


#make check -j24 | tee ../../logs/0022-libtirpc.log


make install -j24
mv /etc/pam.d/system-password{,.orig}
cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# check new passwords for strength (man pam_pwquality)
password  required    pam_pwquality.so   authtok_type=UNIX retry=1 difok=1 \
                                         minlen=8 dcredit=0 ucredit=0 \
                                         lcredit=0 ocredit=0 minclass=1 \
                                         maxrepeat=0 maxsequence=0 \
                                         maxclassrepeat=0 geoscheck=0 \
                                         dictcheck=1 usercheck=1 \
                                         enforcing=1 badwords="" \
                                         dictpath=/usr/lib/cracklib/pw_dict
# use sha512 hash for encryption, use shadow, and use the
# authentication token (chosen password) set by pam_pwquality
# above (or any previous modules)
password  required    pam_unix.so        sha512 shadow use_authtok

# End /etc/pam.d/system-password
EOF



cd ../
rm -rf libpwquality-1.4.4
