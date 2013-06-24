#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    source "$BASE_DIR/common/_func.sh"
    BASE_DIR="$(xrealpath "$BASE_DIR")"
fi
PORT_DIR="$BASE_DIR/ports/icu"

source "$BASE_DIR/common/simulator.sh"

test -f Makefile && make distclean

test -d iports-build-simulator && rm -rf iports-build-simulator
mkdir iports-build-simulator || exit 1
cd iports-build-simulator

CFLAGS="$BASIC_CFLAGS" \
CXXFLAGS="$BASIC_CXXFLAGS" \
CPPFLAGS="$BASIC_CPPFLAGS" \
LDFLAGS="$BASIC_LDFLAGS" \
../configure --host=$CPUARCH-apple-darwin \
    --prefix="$PREFIX" \
    --enable-static --disable-shared \
    --disable-samples \
&& make -j4 \
&& make install \
&& chmod 0644 "$PREFIX/lib/libicu"*.a
