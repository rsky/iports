#!/bin/bash

function xrealpath () {
    local path="$1"
    realpath "$path" 2>/dev/null && return 0
    grealpath "$path" 2>/dev/null && return 0
    ruby -e 'puts File.expand_path(ARGV[0])' "$path" 2>/dev/null && return 0
    return 1
}
