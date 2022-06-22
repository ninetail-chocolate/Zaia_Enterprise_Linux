#!/bin/bash
umount -v $ZEL/dev/pts
umount -v $ZEL/sys/firmware/efi/efivars
umount -v $ZEL/{sys,proc,run,dev}
