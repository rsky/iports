source "$BASE_DIR/common/_compiler_clang.sh"

test -z "$OPTIMIZATION_LEVEL" && OPTIMIZATION_LEVEL="-Os"
test -z "$CMAKE_BUILD_TYPE" && CMAKE_BUILD_TYPE=Release

BIN_FLAGS="-arch $CPUARCH -isysroot $SYSROOT -miphoneos-version-min=5.0"
BASIC_CFLAGS="$BIN_FLAGS $OPTIMIZATION_LEVEL -pipe"
BASIC_CXXFLAGS="$BIN_FLAGS $OPTIMIZATION_LEVEL -pipe"
BASIC_LDFLAGS="$BIN_FLAGS -L$SYSROOT/usr/lib -L$PREFIX/lib"
BASIC_CPPFLAGS="-I$SYSROOT/usr/include -I$PREFIX/include"

PATH="$DEVELOPER_DIR/usr/bin:/usr/bin:$PATH"
export PATH
PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export PKG_CONFIG_PATH
