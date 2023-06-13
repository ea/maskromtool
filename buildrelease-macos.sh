#!/bin/bash
set -e


## This is the script that builds release bundles for macOS, leaving
## the result in release/ in .app and .zip formats.  It does not cross
## compile or make Universal binaries, so I run it on both ARM64 and
## AMD64 macs.  I also don't sign the executables, which is a problem.


## These paths are hardcoded to prevent Homebrew for gunking things
## up.  Be sure to install *everything* in that version of Qt, or
## you'll be missing important libraries like QtCharts.
export QTDIR=~/Qt/6.5.1/macos/bin
export CMAKE=~/Qt/6.5.1/macos/bin/qt-cmake
export DEPLOYQT=~/Qt/6.5.1/macos/bin/macdeployqt



## Remove the old releases.
rm -rf build release

mkdir build
(cd build && $CMAKE .. && make -j 8)

mkdir release
cp -rf build/maskromtool.app release/
# Hardcoding the executable is bad, but the Homebrew version will break the build.
$DEPLOYQT release/maskromtool.app -sign-for-notarization="Developer ID Application: Travis Goodspeed"
# Verify the signature
codesign --verify --verbose  release/maskromtool.app

# Zip up a release.
(cd release && zip -r maskromtool-macos-`uname -m`.zip maskromtool.app)


