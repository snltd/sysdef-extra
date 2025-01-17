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

PROG=libiconv
VER=1.17
PKG=sysdef/library/iconv
SUMMARY="GNU libiconv"
DESC="The GNU iconv implementation"
LDFLAGS[amd64]+=" -L$OPREFIX/lib/amd64 -R$OPREFIX/lib/amd64"
OPREFIX=$PREFIX
PREFIX+="/$PROG"

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

LDFLAGS[amd64]+=" -L$OPREFIX/lib/amd64 -R$OPREFIX/lib/amd64"

set_arch 64
set_ssp none
set_mirror https://ftp.gnu.org
set_checksum sha256 8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313

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
