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

PROG=little-tools
VER=1.2.0
PKG=sysdef/util/little-tools
SUMMARY="Little command-line tools"
DESC="Useful little command-line tools"
BUILD_DEPENDS_IPS=ooce/developer/rust
SKIP_RTIME_CHECK=1
OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
    "

set_arch 64
set_mirror https://github.com
set_checksum sha256 b488299410e8a9f652dd952c4f625984983220a54f1305f55784a7adf9c2ece1
set_ssp none

init
download_source snltd/${PROG}/archive/refs/tags $VER
pushd $TMPDIR/$BUILDDIR >/dev/null
logcmd $CARGO build --release
logcmd mkdir -p ${DESTDIR}/$PREFIX
BINDIR="${DESTDIR}${PREFIX}/bin/"
logcmd mkdir -p $BINDIR
logcmd cp target/release/alsort $BINDIR
logcmd cp target/release/cf $BINDIR
logcmd cp target/release/cs $BINDIR
logcmd cp target/release/fseq $BINDIR
logcmd cp target/release/mmv $BINDIR
popd >/dev/null
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
