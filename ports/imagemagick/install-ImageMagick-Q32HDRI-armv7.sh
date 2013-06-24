#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    PORT_DIR="$(dirname "$0")"
else
    PORT_DIR="$BASE_DIR/ports/imagemagick"
fi

IM_ABI="Q32HDRI"
IM_ARCH="armv7"

source "$PORT_DIR/install-imageMagick-common.sh"
