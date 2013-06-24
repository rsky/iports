#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    PORT_DIR="$(dirname "$0")"
else
    PORT_DIR="$BASE_DIR/ports/tiff"
fi
source "$BASE_DIR/common/simulator.sh"

test -f Makefile && make distclean

CFLAGS="$BASIC_CFLAGS" \
CXXFLAGS="$BASIC_CXXFLAGS" \
CPPFLAGS="$BASIC_CPPFLAGS" \
LDFLAGS="$BASIC_LDFLAGS" \
./configure --host=$CPUARCH-apple-darwin \
    --prefix="$PREFIX" \
    --with-sysroot="$SYSROOT" \
    --enable-static --disable-shared \
    --disable-cxx --disable-jbig --disable-lzma \
    --without-x \
&& make \
&& make install
