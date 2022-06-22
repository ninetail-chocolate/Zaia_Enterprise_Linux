#!/bin/bash
#name="mako"
#version"1.1.5"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://files.pythonhosted.org/packages/source/M/Mako/Mako-1.1.5.tar.gz"
#}
#depend{
#	"markupsafe"
#}
#groupdepend{
#		""
#	}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

source /etc/profile.d/xorg.sh

tar -xf src/Mako-1.1.5.tar.gz
cd Mako-1.1.5

python3 setup.py install --optimize=1




#make check -j32 | tee ../logs/0012-xcb-util-wm.log


#make install


cd ../
rm -rf Mako-1.1.5
