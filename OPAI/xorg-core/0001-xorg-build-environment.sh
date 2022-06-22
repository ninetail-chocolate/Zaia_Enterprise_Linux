#!/bin/bash
#name="xorg-build-environment"
#version="none"
#zel-version="1"
#src{
#	""
#   }
#depend{
#	"bash-initil"
#      }
#comment{
#	""
#	}
#tunebuild="no"
#testhave="no"
#toolchain="no"

export XORG_PREFIX="/usr"
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
########################################################
########################################################
cat > /etc/profile.d/xorg.sh << EOF
XORG_PREFIX="$XORG_PREFIX"
XORG_CONFIG="--prefix=\$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
export XORG_PREFIX XORG_CONFIG
EOF
chmod 644 /etc/profile.d/xorg.sh
###########################################################
###########################################################
mkdir -pv /etc/sudoers.d
cat > /etc/sudoers.d/xorg << EOF
Defaults env_keep += XORG_PREFIX
Defaults env_keep += XORG_CONFIG
EOF

##include sh session
source /etc/profile.d/xorg.sh
