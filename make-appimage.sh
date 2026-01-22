#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q PACKAGENAME | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/512x512/apps/org.fedoraproject.MediaWriter.png
export DESKTOP=/usr/share/applications/org.fedoraproject.MediaWriter.desktop

# Deploy dependencies
quick-sharun /usr/bin/mediawriter /usr/lib/mediawriter/helper /usr/lib/qt6

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
