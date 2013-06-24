#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    PORT_DIR="$(dirname "$0")"
else
    PORT_DIR="$BASE_DIR/ports/curl"
fi
source "$BASE_DIR/common/simulator.sh"

test -f Makefile && make distclean

CFLAGS="$BASIC_CFLAGS" \
CXXFLAGS="$BASIC_CXXFLAGS" \
CPPFLAGS="$BASIC_CPPFLAGS -DHAVE_SOCKET -DHAVE_FCNTL_O_NONBLOCK" \
LDFLAGS="$BASIC_LDFLAGS" \
LIBS="-lresolv" \
./configure --host=$CPUARCH-apple-darwin \
    --prefix="$PREFIX" \
    --with-sysroot="$SYSROOT" \
    --enable-static --disable-shared \
    --with-ssl="$PREFIX" \
&& make \
&& make install
