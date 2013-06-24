#!/bin/bash

BASE_DIR="$(dirname "$0")"
source "$BASE_DIR/common/_base.sh"

mkdir -pv "$COMMON_PREFIX/lib" "$COMMON_PREFIX/make"

# CMake based projects
/usr/bin/python2.7 "$BASE_DIR/makemake.py" \
    --output="$COMMON_PREFIX/make/lipo2.mk" \
    --prefix="$COMMON_PREFIX" \
    --arch armv7 simulator \
    -lpcre -lpcre16 -lpcre32 -lpcrecpp -lpcreposix \
    -lgroonga -llz4 -lqr -lzxing

# configure and/or GNU Autotools based projects
/usr/bin/python2.7 "$BASE_DIR/makemake.py" \
    --output="$COMMON_PREFIX/make/lipo3.mk" \
    --prefix="$COMMON_PREFIX" \
    --arch armv7 armv7s simulator \
    -lssl -lcrypto -lcurl -llzma -lsnappy \
    -licudata -licui18n -licuio -licule -liculx -licutest -licutu -licuuc \
    -ljpeg -lpng16 -ltiff -lwebp -ljasper \
    -llcms2 -lfreetype \
    -lImath -lHalf -lIex -lIexMath -lIlmThread -lIlmImf \
    -lMagickCore-6.Q8 -lMagickWand-6.Q8 \
    -lMagickCore-6.Q16 -lMagickWand-6.Q16 \
    -lMagickCore-6.Q32HDRI -lMagickWand-6.Q32HDRI -lMagick++-6.Q32HDRI \
    -lphp5

cd "$COMMON_PREFIX"
make -f make/lipo2.mk -k all
make -f make/lipo3.mk -k all
