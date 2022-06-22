#!/bin/bash
mkdir -pv $ZEL/{dev,proc,sys,run}
mknod -m 600 $ZEL/dev/console c 5 1
mknod -m 666 $ZEL/dev/null c 1 3
mount -v --bind /dev $ZEL/dev
mount -v --bind /dev/pts $ZEL/dev/pts
mount -vt proc proc $ZEL/proc
mount -vt sysfs sysfs $ZEL/sys
mount -vt tmpfs tmpfs $ZEL/run
mount -v --bind /sys/firmware/efi/efivars $ZEL/sys/firmware/efi/efivars
if [ -h $ZEL/dev/shm ]; then
  mkdir -pv $ZEL/$(readlink $ZEL/dev/shm)
fi
