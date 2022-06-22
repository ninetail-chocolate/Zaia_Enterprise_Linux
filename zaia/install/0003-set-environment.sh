#!/bin/bash
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='[\[\e[1;31m\]ZAIA Enterprise Linux(Installer)\[\e[0m\]]\n[@\[\e[1;32m\]\u\[\e[0m\]]:[\W]\[\e[1;31m\]\$\[\e[0m\]' /bin/bash
EOF
cat > ~/.bashrc << "EOF"
set +h
umask 022
ZEL=/mnt/zel
LC_ALL=POSIX
ZEL_TGT=$(uname -m)-zel-linux-musl
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$ZEL/tools/bin:$ZEL/pretools/bin:$PATH
CONFIG_SITE=$ZEL/usr/share/config.site
export ZEL LC_ALL ZEL_TGT PATH CONFIG_SITE
export MAKEFLAGS="-j24"
EOF
echo "you shoud run reload .bash_profile"
echo "example.) source ~/.bash_profile"
