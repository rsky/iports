#!/bin/bash

source "$(dirname "$0")/common/_func.sh"
BASE_DIR="$(xrealpath "$(dirname "$0")")"
export BASE_DIR

function build_and_install () {
    local port
    local distname
    local version
    local work_dir
    local extra
    local port_dir
    local script_prefix
    local script

    if [ $# -lt 2 ]; then
        echo "$0: Too few arguments!" >&2
        return 1
    fi

    port="$1"

    if [ $# -eq 2 ]; then
        distname="$port"
        version="$2"
    else
        if [ "x$2" = "x-" ]; then
            distname="$port"
        else
            distname="$2"
        fi
        version="$3"
    fi

    if [ $# -gt 4 ]; then
        extra="$5"
        if [ "x$4" = "x-" ]; then
            work_dir="${distname}-${version}"
        else
            work_dir="$4"
        fi
    elif [ $# -eq 4 ]; then
        extra=""
        work_dir="$4"
    else
        extra=""
        work_dir="${distname}-${version}"
    fi

    port_dir="${BASE_DIR}/ports/${port}"
    script_prefix="${port_dir}/install-${distname}"

    test -d "$work_dir" || return 2

    build_base_dir="$(pwd)"

    echo "port     = $port"
    echo "distname = $distname"
    echo "version  = $version"
    echo "extra    = $extra"
    echo "work_dir = $work_dir"

    cd "$work_dir"
    for arch in simulator armv7 armv7s; do
        if [ -z "$extra" ]; then
            script="${script_prefix}-${arch}.sh"
        else
            script="${script_prefix}-${extra}-${arch}.sh"
        fi
        test -f "$script" && bash "$script"
    done
    cd "$build_base_dir"

    return 0
}

build_and_install openssl 1.0.1e
build_and_install curl 7.31.0
build_and_install xz 5.0.4
build_and_install snappy 1.1.0
build_and_install lz4 r97
build_and_install pcre 8.33
build_and_install icu icu4c 51.2 icu/source
build_and_install jpeg libjpeg-turbo 1.3.0
build_and_install png libpng 1.6.2
build_and_install tiff 4.0.3
build_and_install webp libwebp 0.3.1
build_and_install jasper 1.900.1
build_and_install ilmbase 2.0.0
build_and_install openexr 2.0.0
build_and_install lcms lcms2 2.4
build_and_install freetype 2.5.0.1
build_and_install imagemagick ImageMagick 6.8.6-1 - Q8
build_and_install imagemagick ImageMagick 6.8.6-1 - Q16
build_and_install imagemagick ImageMagick 6.8.6-1 - Q32HDRI
build_and_install libqr 1.0.0
build_and_install zxing 2.2
build_and_install groonga 3.0.4
build_and_install php 5.5.0

"$BASE_DIR"/make-universal.sh
