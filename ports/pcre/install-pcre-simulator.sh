#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    source "$BASE_DIR/common/_func.sh"
    BASE_DIR="$(xrealpath "$BASE_DIR")"
fi
PORT_DIR="$BASE_DIR/ports/pcre"

source "$BASE_DIR/common/simulator.sh"

test -d iports-build-simulator && rm -rf iports-build-simulator
mkdir iports-build-simulator || exit 1
cd iports-build-simulator

cmake \
    -D CMAKE_TOOLCHAIN_FILE:PATH="$BASE_DIR/cmake/Toolchain-simulator.cmake" \
    -D CMAKE_INSTALL_PREFIX:PATH="$PREFIX" \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D BUILD_SHARED_LIBS:BOOL=OFF \
    -D PCRE_BUILD_PCRE8:BOOL=ON \
    -D PCRE_BUILD_PCRE16:BOOL=ON \
    -D PCRE_BUILD_PCRE32:BOOL=ON \
    -D PCRE_BUILD_PCRECPP:BOOL=ON \
    -D PCRE_SUPPORT_UTF:BOOL=ON \
    -D PCRE_SUPPORT_UNICODE_PROPERTIES:BOOL=ON \
    -D PCRE_BUILD_PCREGREP:BOOL=ON \
    -D PCRE_SUPPORT_LIBBZ2:BOOL=ON \
    -D PCRE_SUPPORT_LIBZ:BOOL=ON \
    -D PCRE_SUPPORT_LIBEDIT:BOOL=ON \
    -D PCRE_SUPPORT_LIBREADLINE:BOOL=OFF \
    -D PCRE_BUILD_TESTS:BOOL=ON \
    .. \
&& make -j4 \
&& make install
