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

PROG=mp3val
VER=0.1.8
PKG=sysdef/audio/mp3val
SUMMARY="mp3val validates MP3 files"
DESC="tooling to validate audio files"
SKIP_RTIME_CHECK=true
SKIP_SSP_CHECK=true

build() {
  logcmd cd ${TMPDIR}/$BUILDDIR
  logcmd gmake -f Makefile.gcc
  logcmd mkdir -p $DESTDIR${PREFIX}/bin 
  logcmd cp ${TMPDIR}/${BUILDDIR}/mp3val.exe $DESTDIR${PREFIX}/bin/mp3val 
}

set_arch 64
set_mirror https://downloads.sourceforge.net
set_checksum sha256 95a16efe3c352bb31d23d68ee5cb8bb8ebd9868d3dcf0d84c96864f80c31c39f
set_builddir ${PROG}-${VER}-src

init
download_source ${PROG} ${PROG}-${VER}-src
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
