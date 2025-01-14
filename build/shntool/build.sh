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

PROG=shntool
VER=3.0.10
PKG=sysdef/audio/shntool
SUMMARY="shntool manipulates wave data"
DESC="tooling to manipulate audio files"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
    "

CONFIGURE_OPTS="--disable-static
                --prefix=$PREFIX"

set_arch 64
set_mirror http://shnutils.freeshell.org
set_checksum sha256 74302eac477ca08fb2b42b9f154cc870593aec8beab308676e4373a5e4ca2102

init
download_source ${PROG}/dist/src $PROG $VER
prep_build
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
