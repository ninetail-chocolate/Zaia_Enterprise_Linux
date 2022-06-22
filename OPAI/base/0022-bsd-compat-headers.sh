#!/bin/bash
#name="bsd-compat-headers"
#version"roll"
#zel-version="1"
#comment{
#	WTF!?
#}
#src={
#	"https://git.alpinelinux.org/aports/plain/main/libc-dev/sys-cdefs.h"
#	"https://git.alpinelinux.org/aports/plain/main/libc-dev/sys-queue.h"
#	"https://git.alpinelinux.org/aports/plain/main/libc-dev/sys-tree.h"
#
#}
#depend{
#	"musl"
#}
#tunebuild="yes"
#testhave="no"
#toolchain="llvm"

install -D src/sys-cdefs.h "/usr/include/sys/cdefs.h"
install -D src/sys-queue.h "/usr/include/sys/queue.h"
install -D src/sys-tree.h "/usr/include/sys/tree.h"
