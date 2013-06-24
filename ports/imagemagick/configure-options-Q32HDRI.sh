read -d \\ CONFIGURE_OPTIONS <<HERE
--enable-hdri
--disable-opencl
--disable-openmp
--without-modules
--with-magick-plus-plus
--with-quantum-depth=32
--with-jp2
--with-jpeg
--with-lcms2
--with-openexr
--with-png
--with-tiff
--with-webp
--with-zlib
--without-autotrace
--without-bzlib
--without-dps
--without-djvu
--without-fftw
--without-fpx
--without-fontconfig
--without-freetype
--without-gslib
--without-gvc
--without-jbig
--without-lcms
--without-lqr
--without-lzma
--without-pango
--without-perl
--without-rsvg
--without-wmf
--without-x
--without-xml
\\
HERE
CONFIGURE_OPTIONS="$(echo $CONFIGURE_OPTIONS)"