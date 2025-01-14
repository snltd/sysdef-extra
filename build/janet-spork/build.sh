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

PROG=spork
VER=1.0.0
PKG=sysdef/developer/janet-spork
SUMMARY="Janet utility modules"
DESC="The official Janet 'contrib' library"
BUILD_DEPENDS_IPS="
    sysdef/runtime/janet
    sysdef/util/janet-jpm
"
RUN_DEPENDS_IPS="
    sysdef/runtime/janet
    sysdef/util/janet-jpm
"
OPREFIX=$PREFIX
PREFIX+="/janet"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=janet
    -DPKGROOT=janet
    "
SKIP_RTIME_CHECK=1
SKIP_SSP_CHECK=1

remove_errant_hashbang() {
    for f in jpm_tree/bin/*
    do
        gsed -i '1d' $f
    done
}

init
clone_github_source $PROG $GITHUB/janet-lang/$PROG $HASH
logcmd mkdir -p ${DESTDIR}/${PREFIX}
pushd ${TMPDIR}/${BUILDDIR}/spork >/dev/null
logcmd jpm install -l
remove_errant_hashbang
logcmd jpm test
logcmd cp -Rp jpm_tree/* ${DESTDIR}/${PREFIX}/
# DESTDIR=$DESTDIR janet bootstrap.janet configs/omnios_config.janet
popd >/dev/null
make_package
# clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
