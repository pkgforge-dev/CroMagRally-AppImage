#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q cro-mag-rally | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook:wayland-is-broken.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/512x512/apps/cro-mag-rally.png
export DESKTOP=/usr/share/applications/cro-mag-rally.desktop
export STARTUPWMCLASS=CroMagRally
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/lib/cro-mag-rally/CroMagRally
cp -r /usr/lib/cro-mag-rally/Data ./AppDir/bin
echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/bin' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage
