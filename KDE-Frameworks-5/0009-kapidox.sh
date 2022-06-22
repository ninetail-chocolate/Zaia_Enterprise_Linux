#!/bin/bash
#name="kapidox"
#version="5.92.0"
#zel-version="2"
#comment{
#	WTF!?
#}
#src={
#	"https://download.kde.org/stable/frameworks/5.92/kapidox-5.92.0.tar.xz"
#}
#depend{
#	"KF5-pre"
#	"python3"
#	"attica"
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


source /etc/profile

#touch logs/0002-phonon.log
tar -xf src/kapidox-5.92.0.tar.xz
cd kapidox-5.92.0


./bootstrap-devenv.sh

python3 setup.py build


python3 setup.py install


#mkdir DEST
#DESTDIR=$(pwd)/DEST ninja install


#ninja install


cd ../
rm -rf kapidox-5.92.0
