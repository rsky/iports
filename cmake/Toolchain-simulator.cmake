set(DEVELOPER_DIR   /Applications/Xcode.app/Contents/Developer)
set(PLATFORMS_DIR   ${DEVELOPER_DIR}/Platforms)
set(DEVROOT         ${PLATFORMS_DIR}/iPhoneSimulator.platform/Developer)
set(SYSROOT         ${DEVROOT}/SDKs/iPhoneSimulator5.0.sdk)

set(CMAKE_C_COMPILER        /usr/bin/clang)
set(CMAKE_CXX_COMPILER      /usr/bin/clang++)
set(CMAKE_OSX_SYSROOT       ${SYSROOT})
set(CMAKE_OSX_ARCHITECTURES i686 CACHE STRING "OS X Architectures" FORCE)
