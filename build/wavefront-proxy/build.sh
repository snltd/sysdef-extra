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

PROG=wavefront-proxy
VER=13.7
PKG=sysdef/wavefront-proxy
SUMMARY="Wavefront proxy server"
DESC="Resilient metric collection for Wavefront SaaS"
BUILD_DEPENDS_IPS="developer/java/openjdk8 apache-maven"
RUN_DEPENDS_IPS="developer/java/openjdk8"
OPREFIX=$PREFIX
PREFIX+="/$PROG"
PATH=/usr/jdk/instances/openjdk1.8.0/bin:$PATH

set_arch 64
set_mirror https://github.com
set_checksum sha256 42cf250097953ecaf03f1f5904e47e1fd4016066ce3cdf2db645dc45c9adcceb
set_builddir wavefront-proxy-proxy-${VER}

XFORM_ARGS="-DPREFIX=${PREFIX#/} -DPROG=$PROG"

build_jar() {
    cd ${TMPDIR}/${BUILDDIR}
    logcmd mvn -f proxy clean verify -DskipTests -DskipFormatCode \
        || logerr "maven build failed"
}

build_target() {
    logcmd mkdir -p $DESTDIR${PREFIX}/lib $DESTDIR/etc/${OPREFIX}/wavefront-proxy
    logcmd cp ${TMPDIR}/${BUILDDIR}/proxy/target/proxy-${VER}-spring-boot.jar \
              $DESTDIR${PREFIX}/lib/wavefront-proxy.jar \
                || logerr "failed to copy jar"
    logcmd cp ${SRCDIR}/files/log4j2.xml $DESTDIR/etc/${OPREFIX}/wavefront-proxy
}

init
download_source wavefrontHQ/${PROG}/archive/refs/tags proxy-${VER}
patch_source
build_jar
build_target
install_smf application ${PROG}.xml application-${PROG}
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
