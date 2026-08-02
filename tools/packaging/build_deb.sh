#!/bin/bash
# SkyNav Debian Packaging Script

set -e

VERSION="0.1.0"
BUILD_DIR="build/debian/skynav_${VERSION}_amd64"
OUTPUT_DIR="build/linux/x64/release/bundle"

echo "Building Flutter app for Linux..."
flutter build linux --release

echo "Preparing Debian package directory structure..."
rm -rf build/debian
mkdir -p "${BUILD_DIR}/opt/skynav"
mkdir -p "${BUILD_DIR}/usr/share/applications"
mkdir -p "${BUILD_DIR}/usr/share/icons/hicolor/512x512/apps"
mkdir -p "${BUILD_DIR}/DEBIAN"

echo "Copying application files..."
cp -R "${OUTPUT_DIR}/"* "${BUILD_DIR}/opt/skynav/"

echo "Copying assets and desktop entry..."
# Ensure assets exist before copying (will be created in real project)
mkdir -p "${BUILD_DIR}/opt/skynav/assets/icons"
touch "${BUILD_DIR}/opt/skynav/assets/icons/skynav.png"

cp tools/packaging/skynav.desktop "${BUILD_DIR}/usr/share/applications/"
cp tools/packaging/control "${BUILD_DIR}/DEBIAN/"
cp tools/packaging/postinst "${BUILD_DIR}/DEBIAN/"
cp tools/packaging/prerm "${BUILD_DIR}/DEBIAN/"

chmod 0755 "${BUILD_DIR}/DEBIAN/postinst"
chmod 0755 "${BUILD_DIR}/DEBIAN/prerm"

echo "Building .deb package..."
dpkg-deb --build "${BUILD_DIR}"

echo "Package created: build/debian/skynav_${VERSION}_amd64.deb"
