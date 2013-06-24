#!/bin/bash

if [ -z "$BASE_DIR" ]; then
    BASE_DIR="$(dirname "$0")/../.."
    PORT_DIR="$(dirname "$0")"
else
    PORT_DIR="$BASE_DIR/ports/php"
fi
source "$BASE_DIR/common/armv7.sh"

test -f Makefile && make distclean

rm -rf "$PREFIX/include/php"
"$PORT_DIR/fix-offsetof.sh"
source "$PORT_DIR/configure-options.sh"

export CFLAGS="$BASIC_CFLAGS"
export CXXFLAGS="$BASIC_CXXFLAGS"
export CPPFLAGS="$BASIC_CPPFLAGS"
export LDFLAGS="$BASIC_LDFLAGS"
export LIBS="-lresolv"

./configure --host=$CPUARCH-apple-darwin \
    --prefix="$PREFIX" --mandir="$PREFIX/share/man" \
    --with-config-file-path="$PREFIX/etc" \
    --enable-embed=static --disable-cli --disable-cgi \
    --without-pear --without-iconv \
    $LESS_OPTIONS \
&& /usr/bin/sed -i '' 's/\(all_targets = .*\) pharcmd/\1/' Makefile \
&& /usr/bin/sed -i '' 's/#define zend_finite(a) finite(a)/#define zend_finite(a) isfinite(a)/' main/php_config.h \
&& make -j4 \
&& make install-headers install-sapi
