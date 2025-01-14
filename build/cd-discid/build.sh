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
#
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
#
. ../../lib/build.sh

PROG=cd-discid
VER=1.4
VERHUMAN=$VER
PKG=sysdef/audio/cd-discid
SUMMARY="CD identification tool"
DESC="a backend utility to get CDDB discid information from a CD-ROM disc"


build()
{
    export PREFIX
    cd ${TMPDIR}/$BUILDDIR
    gmake
}

set_arch 64
set_ssp none
set_mirror https://github.com
set_checksum sha256 6f07df25ebf17b8336c17a50092ed288cc5a6b86f85705db7e1aa35ba26683cf

init
prep_build
download_source taem/${PROG}/archive/refs/tags $VER ""
patch_source
build
make_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
