#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    glu       \
    libdecor  \
    libgcc    \
    libstdc++ \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package cro-mag-rally

# If the application needs to be manually built that has to be done down here
