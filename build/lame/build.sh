#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}

# Copyright 2023 Sysdef Ltd

. ../../lib/build.sh

PROG=lame
VER=3.100
PKG=sysdef/audio/lame
SUMMARY="The LAME MP3 encoder"
DESC="A high quality MP3 enocder"
SKIP_RTIME_CHECK=1 # because I can't work out how to fix the lnsl thing
CFLAGS+=" -DHAVE_ICONV"
BUILD_DEPENDS_IPS="sysdef/library/iconv"
RUN_DEPENDS_IPS="sysdef/library/iconv"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
    "
CONFIGURE_OPTS+="
    --prefix=$PREFIX
    --enable-nasm
    --disable-analyzer-hooks
    --with-libiconv-prefix=$OPREFIX/libiconv
    "

set_arch 64
set_mirror https://sourceforge.net
set_checksum sha256 ddfe36cab873794038ae2c1210557ad34857a4b6bdc515785d1da9e175b1da1e

init
download_source projects/lame/files/${PROG}/${VER} ${PROG}-${VER}
patch_source
build
test
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
