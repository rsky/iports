#!/bin/bash

BASE_DIR="$(dirname "$0")/.."
source "$BASE_DIR/common/simulator.sh" || exit 1

for arch in armv7 armv7s simulator; do
    prefix="$COMMON_PREFIX/$arch"
    if [ ! -d "$prefix" ]; then
        mkdir -pv "$prefix/share/man" \
        && cd "$prefix" \
        && ln -vs share/man
    fi
done

for arch in armv7 armv7s; do
    prefix="$COMMON_PREFIX/$arch"
    mkdir -pv "$prefix/include" || exit $?
    for header in crt_externs.h tzfile.h; do
        if [ ! -f "$prefix/include/$header" ]; then
            cp -v "$SYSROOT/usr/include/$header" "$prefix/include/$header"
        fi
    done
done
