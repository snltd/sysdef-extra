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

PROG=janet
VER=1.38.0
PKG=sysdef/runtime/janet
SUMMARY="The Janet programming language"
DESC="A functional, imperative Lisp-like programming language"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
    "

configure_amd64() {
    :
}

build_fini() {
    # Run the test suite
    cd ${TMPDIR}/$BUILDDIR
    gmake test
}

set_arch 64
set_mirror https://github.com
set_checksum sha256 84dbf7db9c09677618549fb4be23631fd64f527af21051db02753241a2f6f752

# create package functions
init
download_source janet-lang/janet/archive/refs/tags v${VER}
patch_source
PREFIX=$PREFIX build -noctf
test
strip_install
make_package
#clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
