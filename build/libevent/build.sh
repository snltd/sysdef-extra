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

# Copyright 2023 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=libevent
VER=2.1.12
PKG=sysdef/library/libevent
SUMMARY=$PROG
DESC="$PROG - event handling library"
OPREFIX=$PREFIX
PREFIX+="/$PROG"
SKIP_RTIME_CHECK=1
SKIP_SSP_CHECK=1

BUILD_DEPENDS_IPS="
    ooce/developer/cmake
"

set_arch 64
set_mirror https://github.com
set_checksum sha256 92e6de1be9ec176428fd2367677e61ceffc2ee1cb119035037a27d346b0403bb
set_builddir ${PROG}-${VER}-stable

CONFIGURE_OPTS="
    -DCMAKE_BUILD_TYPE=Release 
    -DCMAKE_INSTALL_PREFIX=$PREFIX 
    -DEVENT__DISABLE_BENCHMARK=ON 
    -DEVENT__DISABLE_TESTS=ON 
    -DEVENT__DISABLE_SAMPLES=ON 
"

CONFIGURE_OPTS[i386]=
CONFIGURE_OPTS[amd64]="
    -DCMAKE_INSTALL_LIBDIR=$OPREFIX/lib/amd64
"
CONFIGURE_OPTS[aarch64]=

LDFLAGS[amd64]+=" -L$OPREFIX/lib/amd64 -Wl,-R$OPREFIX/lib/amd64"
LDFLAGS[i386]+=" -L$OPREFIX/lib -Wl,-R$OPREFIX/lib"

init
download_source libevent/libevent/releases/download/release-${VER}-stable ${PROG} ${VER}-stable
prep_build cmake
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
