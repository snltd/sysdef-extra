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

PROG=samba
VER=3.6.25
PKG=sysdef/util/samba
SUMMARY="CIFS file server"
DESC="Makes files available over the CIFS protocol"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
    "

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --enable-static
    --includedir=$OPREFIX/include
"


set_arch 64
set_mirror https://download.samba.org/
set_checksum sha256 8f2c8a7f2bd89b0dfd228ed917815852f7c625b2bc0936304ac3ed63aaf83751

init
download_source pub/${PROG}/stable $PROG-$VER
prep_build
patch_source
BUILDDIR="${BUILDDIR}/source3/"
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
