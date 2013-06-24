source "$BASE_DIR/common/_base.sh"

CPUARCH="i686"
SDKNAME="iPhoneSimulator5.0.sdk"
DEVROOT="$PLATFORMS_DIR/iPhoneSimulator.platform/Developer"
SYSROOT="$DEVROOT/SDKs/$SDKNAME"
PREFIX="$COMMON_PREFIX/simulator"

source "$BASE_DIR/common/_env.sh"

BASIC_LDFLAGS="$BASIC_LDFLAGS -L$SYSROOT/usr/lib/system"
