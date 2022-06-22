#!/bin/bash
#name="pygments"
#version="2.10.0"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://files.pythonhosted.org/packages/source/P/Pygments/Pygments-2.10.0.tar.gz"
#}
#depend{
#	"python3"
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

#touch logs/0038-libvpx.log
tar -xf src/Pygments-2.10.0.tar.gz
cd Pygments-2.10.0


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


python3 setup.py install --optimize=1


cd ../
rm -rf Pygments-2.10.0
