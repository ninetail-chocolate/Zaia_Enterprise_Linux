#!/bin/bash
chown -Rv root:root $ZEL/{usr,lib,var,etc,bin,sbin,tools,pretools}
case $(uname -m) in
  x86_64) chown -Rv root:root $ZEL/lib64 ;;
esac
