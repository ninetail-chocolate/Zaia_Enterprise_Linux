#!/bin/bash
mkdir -pv $ZEL/{etc,var} $ZEL/usr/{bin,lib,sbin}
for i in bin lib sbin; do
  ln -sv usr/$i $ZEL/$i
done
case $(uname -m) in
  x86_64) mkdir -pv $ZEL/lib64 ;;
esac
mkdir -pv $ZEL/tools
mkdir -pv $ZEL/pretools
