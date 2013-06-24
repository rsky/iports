#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    source "$BASE_DIR/common/_func.sh"
    BASE_DIR="$(xrealpath "$BASE_DIR")"
fi
PORT_DIR="$BASE_DIR/ports/icu"

source "$BASE_DIR/common/armv7.sh"

test -f Makefile && make distclean

ICU_SOURCE_DIR="$(pwd)"

test -d iports-build-armv7 && rm -rf iports-build-armv7
mkdir iports-build-armv7 || exit 1
cd iports-build-armv7

CFLAGS="$BASIC_CFLAGS" \
CXXFLAGS="$BASIC_CXXFLAGS" \
CPPFLAGS="$BASIC_CPPFLAGS" \
LDFLAGS="$BASIC_LDFLAGS" \
../configure --host=$CPUARCH-apple-darwin \
    --prefix="$PREFIX" \
    --with-cross-build="$ICU_SOURCE_DIR/iports-build-simulator" \
    --enable-static --disable-shared \
    --disable-samples \
&& make -j4 \
&& make install \
&& chmod 0644 "$PREFIX/lib/libicu"*.a
