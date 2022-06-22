#!/bin/bash
groupadd zel
useradd -s /bin/bash -g zel -m -k /dev/null zel
chown -Rv zel $ZEL/{usr{,/*},lib,var,etc,bin,sbin,tools,pretools}
case $(uname -m) in
  x86_64) chown -v zel $ZEL/lib64 ;;
esac
chown -Rv zel $ZEL/usr/zaia
echo "you shoud change passwd zel"
echo "after switch to zel"
echo "example.) su - zel"
