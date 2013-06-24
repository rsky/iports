#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    PORT_DIR="$(dirname "$0")"
else
    PORT_DIR="$BASE_DIR/ports/ilmbase"
fi
source "$BASE_DIR/common/armv7.sh"

test -f Makefile && make distclean

CFLAGS="$BASIC_CFLAGS" \
CXXFLAGS="$BASIC_CXXFLAGS" \
CPPFLAGS="$BASIC_CPPFLAGS" \
LDFLAGS="$BASIC_LDFLAGS" \
./configure --host=$CPUARCH-apple-darwin \
    --prefix="$PREFIX" \
    --enable-static --disable-shared \
&& make \
|| cp "$PORT_DIR/eLut-armv7.h" Half/eLut.h
make \
|| cp "$PORT_DIR/toFloat-armv7.h" Half/toFloat.h
make && make install
