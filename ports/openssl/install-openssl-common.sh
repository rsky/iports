#!/bin/bash

test -f Makefile && make clean

export CC="$CC -arch $CPUARCH"
export CXX="$CXX -arch $CPUARCH"
export LD="$LD -arch $CPUARCH"
export CROSS_TOP="$DEVROOT"
export CROSS_SDK="$SDKNAME"

./Configure --prefix="$PREFIX" \
    --openssldir="$PREFIX/etc/openssl" \
    no-shared zlib no-krb5 iphoneos-cross \
&& make \
&& make install_sw
