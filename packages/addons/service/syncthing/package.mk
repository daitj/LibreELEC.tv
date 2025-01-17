# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="syncthing"
PKG_VERSION="1.20.1"
PKG_SHA256="a88fabaea11a8df5cc134075c37dc87f1fb33b48d3d8afb1dc8ea11b3c0925bc"
PKG_REV="120"
PKG_ARCH="any"
PKG_LICENSE="MPLv2"
PKG_SITE="https://syncthing.net/"
PKG_URL="https://github.com/syncthing/syncthing/releases/download/v${PKG_VERSION}/syncthing-source-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="service/system"
PKG_SHORTDESC="Syncthing: open source continuous file synchronization"
PKG_LONGDESC="Syncthing (${PKG_VERSION}) replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Syncthing"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

configure_target() {
  go_configure
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld ${CC} \
                  -X github.com/syncthing/syncthing/lib/build.Version=v${PKG_VERSION}"
}

make_target() {
  ${GOLANG} build -a -ldflags "${LDFLAGS}" -o bin/syncthing -v ./cmd/syncthing
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_BUILD}/bin/syncthing \
        ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
