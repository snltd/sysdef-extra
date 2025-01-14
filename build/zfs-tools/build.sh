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

PROG=zfs-tools
VER=2.0.3
PKG=sysdef/util/zfs-tools
SUMMARY="Command-line tools which perform ZFS-related tasks"
DESC="ZFS-related command-line tools"
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
set_ssp none
set_builddir zfs-tools-rs-${VER}
set_checksum sha256 6b5bc930ab0b125a6e976871b1a4c967622d79cb0b4ffd7a36804101ca00f609

init
download_source snltd/zfs-tools-rs/archive/refs/tags $VER
pushd $TMPDIR/$BUILDDIR >/dev/null
logcmd $CARGO build --release
logcmd mkdir -p ${DESTDIR}/$PREFIX
BINDIR="${DESTDIR}${PREFIX}/bin/"
logcmd mkdir -p $BINDIR
logcmd cp target/release/zfs-real-usage $BINDIR
logcmd cp target/release/zfs-remove-snaps $BINDIR
logcmd cp target/release/zfs-rogue-snaps $BINDIR
logcmd cp target/release/zfs-snap $BINDIR
logcmd cp target/release/zfs-touch-from-snap $BINDIR
logcmd cp target/release/zp $BINDIR
logcmd cp target/release/zr $BINDIR
popd >/dev/null
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
