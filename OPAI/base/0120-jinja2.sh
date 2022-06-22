#!/bin/bash
#name="jinja2"
#version"3.0.3"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"wget -O jinja-3.0.3.tar.gz https://github.com/pallets/jinja/archive/refs/tags/3.0.3.tar.gz"
#}
#depend{
#	"python3"
#	"markupsafe"
#}
#commnet{
#	""
#	}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"


tar -xf src/jinja-3.0.3.tar.gz
cd jinja-3.0.3


python3 setup.py install --optimize=1


cd ../
rm -rf jinja-3.0.3
