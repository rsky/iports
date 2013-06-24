#!/bin/bash

cd "$(dirname "$0")"

case "$1" in
"-cmake"|"-configure")
    port_type="${1#-}"
    if [ $# -eq 2 ]; then
        port="$2"
        distname="$2"
    elif [ $# -eq 3 ]; then
        port="$2"
        distname="$3"
    else
        echo "intalid arguments: $@" >&2
        exit 1
    fi
    ;;
*)
    port_type=configure
    if [ $# -eq 1 ]; then
        port="$1"
        distname="$1"
    elif [ $# -eq 2 ]; then
        port="$1"
        distname="$2"
    else
        echo "intalid arguments: $@" >&2
        exit 1
    fi
    ;;
esac

port_dir="ports/$port"
mkdir -v "$port_dir" || exit 1

cp templates/INFO "$port_dir/"
archs="armv7 armv7s simulator"
if [ "$port_type" = "cmake" ]; then
    archs="armv7 simulator"
fi

for arch in $archs; do
    cat "templates/$port_type.sh.in" \
        | sed "s/__arch__/$arch/g" \
        | sed "s/__distname__/$distname/g" \
        | sed "s/__port__/$port/g" \
        > "$port_dir/install-$distname-$arch.sh"
done

chmod 0755 "$port_dir/install-$distname-"*.sh
ls -l "$port_dir"
