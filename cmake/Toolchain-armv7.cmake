set(DEVELOPER_DIR   /Applications/Xcode.app/Contents/Developer)
set(PLATFORMS_DIR   ${DEVELOPER_DIR}/Platforms)
set(DEVROOT         ${PLATFORMS_DIR}/iPhoneOS.platform/Developer)
set(SYSROOT         ${DEVROOT}/SDKs/iPhoneOS6.1.sdk)

set(CMAKE_C_COMPILER        /usr/bin/clang)
set(CMAKE_CXX_COMPILER      /usr/bin/clang++)
set(CMAKE_OSX_SYSROOT       ${SYSROOT})
set(CMAKE_OSX_ARCHITECTURES "armv7;armv7s" CACHE STRING "OS X Architectures" FORCE)
