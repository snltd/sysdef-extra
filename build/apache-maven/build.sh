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

PROG=apache-maven
VER=3.9.1
PKG=sysdef/developer/apache-maven
SUMMARY="Java build automation tool"
DESC="Software project management and comprehension tool"
BUILD_DEPENDS_IPS="developer/java/openjdk8"
OPREFIX=$PREFIX
PREFIX+="/$PROG"
XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPKGROOT=$PROG
    "

set_mirror https://dlcdn.apache.org

init
download_source maven/maven-3/${VER}/binaries $PROG ${VER}-bin
mkdir -p "${DESTDIR}${PREFIX}"
rsync -a $TMPDIR/$BUILDDIR/ "${DESTDIR}${PREFIX}"
rm -fr "${DESTDIR}${PREFIX}/lib/jansi-native"
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
