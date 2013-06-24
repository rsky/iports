#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    PORT_DIR="$(dirname "$0")"
else
    PORT_DIR="$BASE_DIR/ports/openssl"
fi
source "$BASE_DIR/common/armv7s.sh"

source "$PORT_DIR/install-openssl-common.sh"
