#!/bin/bash
chroot "$ZEL" /usr/bin/env -i		\
	HOME=/root			\
	TERM="$TERM"			\
	PS1='[\[\e[1;31m\]ZAIA Enterprise Linux(installer-chroot)\[\e[0m\]]\n[@\[\e[1;32m\]\u\[\e[0m\]]:[\W]\[\e[1;31m\]\$\[\e[0m\]'	\
	PATH=/usr/bin:/usr/sbin		\
	/bin/bash --login
