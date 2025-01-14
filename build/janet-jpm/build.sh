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

PROG=jpm
VER=1.1.0
PKG=sysdef/util/janet-jpm
SUMMARY="The Janet Package Manager"
DESC="Janet's Package Manager"
BUILD_DEPENDS_IPS="sysdef/runtime/janet"
RUN_DEPENDS_IPS="sysdef/runtime/janet"
OPREFIX=$PREFIX
PREFIX+="/janet"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=janet
    -DPKGROOT=janet
    "

set_mirror https://github.com
set_checksum sha256 337c40d9b8c087b920202287b375c2962447218e8e127ce3a5a12e6e47ac6f16
unset JANET_TREE

init
download_source janet-lang/${PROG}/archive/refs/tags v$VER
logcmd mkdir -p ${DESTDIR}/${PREFIX}/lib/janet/.manifests
logcmd mkdir -p ${DESTDIR}/${PREFIX}/share/man/man1
pushd $TMPDIR/$BUILDDIR >/dev/null
logcmd cp ${SRCDIR}/files/omnios_config.janet ${TMPDIR}/${BUILDDIR}/configs/
DESTDIR=$DESTDIR JANET_JPM_CONFIG=omnios_config.janet janet bootstrap.janet configs/omnios_config.janet
popd >/dev/null
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
