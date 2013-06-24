#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    source "$BASE_DIR/common/_func.sh"
    BASE_DIR="$(xrealpath "$BASE_DIR")"
fi
PORT_DIR="$BASE_DIR/ports/libqr"

source "$BASE_DIR/common/simulator.sh"

test -d iports-build-simulator && rm -rf iports-build-simulator
mkdir iports-build-simulator || exit 1
cd iports-build-simulator

cmake \
    -D CMAKE_TOOLCHAIN_FILE:PATH="$BASE_DIR/cmake/Toolchain-simulator.cmake" \
    -D CMAKE_INSTALL_PREFIX:PATH="$PREFIX" \
    -D CMAKE_BUILD_TYPE:STRING="$CMAKE_BUILD_TYPE" \
    .. \
&& make \
&& make install
