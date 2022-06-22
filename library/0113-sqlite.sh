#!/bin/bash
#name="sqlite"
#version="2.94"
#zel-version="1"
#comment{
#	"WTF!?"
#}
#src={
#	"https://github.com/storaged-project/udisks/releases/download/udisks-2.9.4/udisks-2.9.4.tar.bz2"
#}
#depend{
#	"gobject-introspection"
#	"libatasmart"
#	"libblockdev"
#	"libgudev"
#	"libxslt"
#	"polkit"
#	"dbus"
#	"elogind"
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


#touch logs/0038-libvpx.log
tar -xf src/sqlite-autoconf-3380000.tar.gz
cd sqlite-autoconf-3380000


mkdir build
cd build


CC=clang					\
CXX=clang++					\
../configure					\
	--prefix=/usr				\
	--sysconfdir=/etc			\
	--disable-static			\
	--enable-shared				\
	--enable-fts5     \
            CPPFLAGS="-DSQLITE_ENABLE_FTS3=1            \
                      -DSQLITE_ENABLE_FTS4=1            \
                      -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                      -DSQLITE_ENABLE_UNLOCK_NOTIFY=1   \
                      -DSQLITE_ENABLE_DBSTAT_VTAB=1     \
                      -DSQLITE_SECURE_DELETE=1          \
                      -DSQLITE_ENABLE_FTS3_TOKENIZER=1"


make -j32


#make test -j32 | tee ../../logs/0038-libvpx.log


#mkdir DEST
#make DESTDIR=$(pwd)/DEST install


make install


cd ../../
rm -rf sqlite-autoconf-3380000
