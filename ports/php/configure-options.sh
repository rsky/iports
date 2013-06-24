read -d \\ GD_FULL_OPTIONS <<HERE
--with-gd
--with-jpeg-dir=$PREFIX
--with-png-dir=$PREFIX
--with-freetype-dir=$PREFIX
--without-vpx-dir
--enable-gd-native-ttf
--enable-gd-jis-conv
\\
HERE
GD_FULL_OPTIONS="$(echo $GD_FULL_OPTIONS)"

read -d \\ GD_LESS_OPTIONS <<HERE
--with-gd
--with-jpeg-dir=$PREFIX
--with-png-dir=$PREFIX
--without-vpx-dir
--without-freetype-dir
\\
HERE
GD_LESS_OPTIONS="$(echo $GD_LESS_OPTIONS)"

read -d \\ FULL_OPTIONS <<HERE
--enable-exif
--enable-intl
--enable-mbstring
--enable-zip
--with-bz2
--with-zlib
--with-icu-dir=$PREFIX
--with-curl=$PREFIX
--with-openssl
--with-openssl-dir
$GD_FULL_OPTIONS
\\
HERE
FULL_OPTIONS="$(echo $FULL_OPTIONS)"

read -d \\ LESS_OPTIONS <<HERE
--enable-exif
--enable-mbstring
--with-zlib
--with-curl=$PREFIX
--with-openssl
--with-openssl-dir
$GD_LESS_OPTIONS
\\
HERE
LESS_OPTIONS="$(echo $LESS_OPTIONS)"
