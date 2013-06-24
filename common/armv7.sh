source "$BASE_DIR/common/_base.sh"

CPUARCH="armv7"
SDKNAME="iPhoneOS6.1.sdk"
DEVROOT="$PLATFORMS_DIR/iPhoneOS.platform/Developer"
SYSROOT="$DEVROOT/SDKs/$SDKNAME"
PREFIX="$COMMON_PREFIX/armv7"

source "$BASE_DIR/common/_env.sh"
