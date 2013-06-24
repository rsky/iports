#!/bin/bash

source "$BASE_DIR/common/$IM_ARCH.sh"
source "$PORT_DIR/configure-options-$IM_ABI.sh"

test -f Makefile && make distclean

IM_DEFAULT_ABI="Q8"
IM_LIB_VERSION="6"
IM_PREFIX="$COMMON_PREFIX/imagemagick/$IM_ABI/$IM_ARCH"
IM_PREFIX_REF="../../imagemagick/$IM_ABI/$IM_ARCH"

EXTRA_LDFLAGS=""
PLUS_PLUS=0

case "$CONFIGURE_OPTIONS" in
    *--with-magick-plus-plus*--with-openexr*)
        PLUS_PLUS=1
        EXTRA_LDFLAGS="-lstdc++"
        ;;
    *--with-magick-plus-plus*)
        PLUS_PLUS=1
        ;;
    *--with-openexr*)
        EXTRA_LDFLAGS="-lstdc++"
        ;;
esac

IM_INSTALL_TARGETS="install-magickincarchHEADERS install-magickincHEADERS install-wandincHEADERS"
if [ $PLUS_PLUS -eq 1 ]; then
    IM_INSTALL_TARGETS="$IM_INSTALL_TARGETS install-magickppincHEADERS install-magickpptopincHEADERS"
fi
IM_INSTALL_TARGETS="$IM_INSTALL_TARGETS install-pkgconfigDATA install-binSCRIPTS"
case "$IM_PREFIX" in
    */simulator)
    IM_INSTALL_TARGETS="$IM_INSTALL_TARGETS install-binPROGRAMS"
    ;;
    *)
    IM_INSTALL_TARGETS="$IM_INSTALL_TARGETS install-libLTLIBRARIES"
    ;;
esac

CFLAGS="$BASIC_CFLAGS" \
CXXFLAGS="$BASIC_CXXFLAGS" \
CPPFLAGS="$BASIC_CPPFLAGS" \
LDFLAGS="$BASIC_LDFLAGS $EXTRA_LDFLAGS" \
./configure --host=$CPUARCH-apple-darwin \
    --prefix="$IM_PREFIX" \
    --with-sysroot="$SYSROOT" \
    --enable-static --disable-shared \
    $CONFIGURE_OPTIONS \
&& make -j4 \
&& make $IM_INSTALL_TARGETS

# symlink header directory
cd "$PREFIX/include"
pwd
if [ "$IM_ABI" = "$IM_DEFAULT_ABI" ]; then
    rm -f "ImageMagick-$IM_LIB_VERSION"
    ln -sv "$IM_PREFIX_REF/include/ImageMagick-$IM_LIB_VERSION"
fi

# symlink static libraries
cd "$PREFIX/lib"
pwd
rm -f "libMagick++-$IM_LIB_VERSION.$IM_ABI.a"
rm -f "libMagickCore-$IM_LIB_VERSION.$IM_ABI.a"
rm -f "libMagickWand-$IM_LIB_VERSION.$IM_ABI.a"
ln -sv "$IM_PREFIX_REF/lib/libMagickCore-$IM_LIB_VERSION.$IM_ABI.a"
ln -sv "$IM_PREFIX_REF/lib/libMagickWand-$IM_LIB_VERSION.$IM_ABI.a"
if [ $PLUS_PLUS -eq 1 ]; then
    ln -sv "$IM_PREFIX_REF/lib/libMagick++-$IM_LIB_VERSION.$IM_ABI.a"
else
    rm -f "$IM_PREFIX/lib/libMagick++-$IM_LIB_VERSION.$IM_ABI.a"
fi
