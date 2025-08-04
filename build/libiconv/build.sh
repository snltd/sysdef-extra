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

# Copyright 2025 Sysdef Ltd

. ../../lib/build.sh

PROG=libiconv
VER=1.18
PKG=sysdef/library/iconv
SUMMARY="GNU libiconv"
DESC="The GNU iconv implementation"
OPREFIX=$PREFIX
PREFIX+="/$PROG"
LDFLAGS[amd64]+=" -L/opt/ooce/libiconv/lib/amd64 -Wl,-R/opt/ooce/libiconv/lib/amd64"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
    "

CONFIGURE_OPTS[amd64]="
    --bindir=$PREFIX/bin
    --sbindir=$PREFIX/sbin
    --libdir=$OPREFIX/lib/amd64
"


set_arch 64
set_ssp none
set_mirror https://ftp.gnu.org
set_checksum sha256 3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8

init
download_source pub/gnu/$PROG ${PROG}-$VER
patch_source
build
test
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
