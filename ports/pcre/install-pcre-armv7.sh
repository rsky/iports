#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    source "$BASE_DIR/common/_func.sh"
    BASE_DIR="$(xrealpath "$BASE_DIR")"
fi
PORT_DIR="$BASE_DIR/ports/pcre"

source "$BASE_DIR/common/armv7.sh"

test -d iports-build-armv7 && rm -rf iports-build-armv7
mkdir iports-build-armv7 || exit 1
cd iports-build-armv7

cmake \
    -D CMAKE_TOOLCHAIN_FILE:PATH="$BASE_DIR/cmake/Toolchain-armv7.cmake" \
    -D CMAKE_INSTALL_PREFIX:PATH="$PREFIX" \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D BUILD_SHARED_LIBS:BOOL=OFF \
    -D PCRE_BUILD_PCRE8:BOOL=ON \
    -D PCRE_BUILD_PCRE16:BOOL=ON \
    -D PCRE_BUILD_PCRE32:BOOL=ON \
    -D PCRE_BUILD_PCRECPP:BOOL=ON \
    -D PCRE_SUPPORT_UTF:BOOL=ON \
    -D PCRE_SUPPORT_UNICODE_PROPERTIES:BOOL=ON \
    -D PCRE_BUILD_PCREGREP:BOOL=OFF \
    -D PCRE_SUPPORT_LIBBZ2:BOOL=OFF \
    -D PCRE_SUPPORT_LIBZ:BOOL=OFF \
    -D PCRE_SUPPORT_LIBEDIT:BOOL=OFF \
    -D PCRE_SUPPORT_LIBREADLINE:BOOL=OFF \
    -D PCRE_BUILD_TESTS:BOOL=OFF \
    .. \
&& make -j4 \
&& make install
