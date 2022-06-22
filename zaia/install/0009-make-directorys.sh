#!/bin/bash
echo "create directorys"
mkdir -pv /{boot,home,mnt,opt,srv}
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}
ln -sfv /run /var/run
ln -sfv /run/lock /var/lock
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
echo "END create directorys"

ln -sv /proc/self/mounts /etc/mtab
cat > /etc/hosts << EOF
::1        localhost
127.0.0.1  localhost $(hostname)
EOF


cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/bin/false
daemon:x:2:2:daemon:/sbin:/bin/false
adm:x:3:4:adm:/var/adm:/bin/false
lp:x:4:7:lp:/var/spool/lpd:/bin/false
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
news:x:9:13:news:/var/spool/news:/bin/false
uucp:x:10:14:uucp:/var/spool/uucp:/bin/false
operator:x:11:0:operator:/root:/sbin/nologin
nobody:x:65534:65534:nobody:/var/empty:/bin/false
man:x:13:15:System user; man:/dev/null:/sbin/nologin
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
sshd:x:22:22:User for ssh:/var/empty:/sbin/nologin
ldap:x:83:83:OpenLDAP Daemon Owner:/var/lib/openldap:/bin/false
EOF


cat > /etc/group << "EOF"
root:x:0:root
bin:x:1:root,bin,daemon
daemon:x:2:root,bin,daemon
sys:x:3:root,bin,adm
adm:x:4:root,adm,daemon
tty:x:5:
disk:x:6:root,adm
lp:x:7:lp
mem:x:8:
kmem:x:9:
wheel:x:10:root
floppy:x:11:root
news:x:13:news
uucp:x:14:uucp
console:x:17:
audio:x:18:
cdrom:x:19:
dialout:x:20:
tape:x:26:root
video:x:27:root
cdrw:x:80:
usb:x:85:
input:x:97:
users:x:1000:
utmp:x:406:
nogroup:x:65533:
nobody:x:65534:
man:x:15:
messagebus:x:18:
uuidd:x:80:
sshd:x:22:
kvm:x:78:
render:x:28:
sgx:x:405:
ldap:x:83:
EOF


cat > /etc/resolv.conf <<EOF
#################################
#### default resolv.conf
search one.one.one.one
nameserver 1.1.1.1
nameserver 2606:4700:4700::1111
#################################
EOF


touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp

echo "you shoud re-chroot."
