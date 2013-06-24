#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    source "$BASE_DIR/common/_func.sh"
    BASE_DIR="$(xrealpath "$BASE_DIR")"
fi
PORT_DIR="$BASE_DIR/ports/groonga"

source "$BASE_DIR/common/armv7.sh"

test -d iports-build-armv7 && rm -rf iports-build-armv7
mkdir iports-build-armv7 || exit 1
cd iports-build-armv7

cmake \
    -D CMAKE_TOOLCHAIN_FILE:PATH="$BASE_DIR/cmake/Toolchain-armv7.cmake" \
    -D CMAKE_INSTALL_PREFIX:PATH="$PREFIX" \
    -D CMAKE_BUILD_TYPE:STRING="$CMAKE_BUILD_TYPE" \
    -D GRN_WITH_NFKC:BOOL=ON \
    -D GRN_WITH_STATIC:BOOL=ON \
    -D GRN_WITH_ZLIB:BOOL=OFF \
    -D GRN_WITH_LZO:BOOL=OFF \
    -D GRN_WITH_MECAB:STRING=no \
    -D GRN_WITH_KYTEA:STRING=no \
    -D GRN_WITH_ZEROMQ:STRING=no \
    -D GRN_WITH_LIBEVENT:STRING=no \
    -D GRN_WITH_MESSAGE_PACK:STRING=no \
    .. \
&& make -j4 \
&& make install
