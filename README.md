# The cross-compiling tools for iOS

## Features

* Build open source ports for iOS (armv7 and armv7s) and iOS Simulator.
* Create fat (armv7, armv7s and i386) static libraries.

## Requirements

* Mac OS X (>= 10.7, tested on 10.8.3)
* Xcode (>= 4.5, tested with 4.6.2)
	* Command Line Tools
	* iOS 5.0 Simulator
* [CMake](http://www.cmake.org/) (>=2.8.9, tested with 2.8.10.2)
	* [Homebrew](http://mxcl.github.io/homebrew/): `brew install cmake`
	* [MacPorts](http://www.macports.org/): `port install cmake`

## Supporting Libraries

### curl (cURL 7.31.0)

* homepage: http://curl.haxx.se/
* license: MIT/X
* provides: libcurl.a
* dependencies: openssl (libcrypto.a, libssl.a), *libresolv.dylib*, *libz.dylib*

### freetype (FreeType 2.5.0.1)

* homepage: http://www.freetype.org/
* license: FTL (BSD-style), GPL v2
* provides: libfreetype.a
* dependencies: *libz.dylib*, *libbz2.dylib*

### icu (ICU4C 51.2)

* homepage: http://www.icu-project.org/
* license: MIT
* provides: libicudata.a, libicui18n.a, libicuio.a, libicule.a, libiculx.a, libicutest.a, libicutu.a, libicuuc.a
* dependencies: *libstdc++.6.dylib*

### imagemagick (ImageMagick 6.8.6-1 Q8, Q16, Q32HDRI)

* homepage: http://www.imagemagick.org/
* license: Apache 2.0

**Q8** *(--with-quantum-depth=8)*

* provides: libMagickCore-6.Q8.a, libMagickWand-6.Q8.a
* dependencies: jpeg, lcms, png, tiff, webp (libjpeg.a, liblcms2.a, libpng16.a, libtiff.a, libwebp.a) *libz.dylib*

**Q16** *(--with-quantum-depth=16)*

* provides: libMagickCore-6.Q16.a, libMagickWand-6.Q16.a
* dependencies: jpeg, lcms, png, tiff, webp (libjpeg.a, liblcms2.a, libpng16.a, libtiff.a, libwebp.a) *libz.dylib*

**Q32HDRI** *(--with-quantum-depth=32 --enable-hdri --with-magick-puls-plus)*

* provides: libMagickCore-6.Q32HDRI.a, libMagickWand-6.Q32HDRI.a, libMagick++-6.Q32HDRI.a
* dependencies: ilmbase, jasper, jpeg, lcms, openexr, png, tiff, webp (libHalf.a, libIex.a, libIexMath.a, libIlmImf.a, libIlmThread.a, libImath.a, libjpeg.a, liblcms2.a, libpng16.a, libtiff.a, libwebp.a) *libstdc++.6.dylib*, *libz.dylib*

### jasper (JasPer 1.900.1)

* homepage: http://www.ece.uvic.ca/~frodo/jasper/
* license: JasPer 2.0 (MIT-style)
* provides: libjasper.a
* dependencies: none

### jpeg (libjpeg-turbo 1.3.0, compatible with IJG libjpeg v8)

* homepage: http://libjpeg-turbo.virtualgl.org/
* license: BSD
* provides: libjpeg.a
* dependencies: none

### lcms (Little CMS 2.4)

* homepage: http://www.littlecms.com/
* license: MIT
* provides: liblcms2.a
* dependencies: none

### libqr (libqr 1.0.0-dev)

* homepage: https://github.com/rsky/qrcode
* license: MIT
* provides: libqr.a
* dependencies: *libz.dylib*

### lz4 (LZ4 svn r97)

* homepage: http://fastcompression.blogspot.jp/p/lz4.html https://code.google.com/p/lz4/
* license: New BSD
* provides: libcurl.a
* dependencies: none

### openexr/ilmbase (OpenEXR 2.0.0 + IlmBase 2.0.0)

* homepage: http://www.openexr.com/
* license: Modified BSD
* provides: libHalf.a, libIex.a, libIexMath.a, libIlmImf.a, libIlmThread.a, libImath.a
* dependencies: *libstdc++.6.dylib*

### openssl (OpenSSL 1.0.1e)

* homepage: http://www.openssl.org/
* license: OpenSSL SSLeay (Apache-style)
* provides: libcrypto.a, libssl.a
* dependencies: *libresolv.dylib*

### pcre (PCRE 8.33)

* homepage: http://www.pcre.org/
* license: New BSD
* provides: pcre.a, libpcre16.a, libpcre32.a, libpcrecpp.a, libpcreposix.a
* dependencies: none

### php (PHP 5.5.0 embed SAPI)

* homepage: http://www.php.net/
* license: PHP 3.01
* provides: libphp5.a
* dependencies: curl, jasper, jpeg, lcms, openexr, openssl, png, tiff (libcrypto.a, libcurl.a, libjpeg.a, libpng16.a, libssl.a), *libbz2.dylib*, *libresolv.dylib*, *libxml2.dylib*, *libz.dylib*
* modules: bz2, Core, ctype, curl, date, dom, ereg, exif, fileinfo, filter, gd, hash, json, libxml, mbstring, openssl, pcre, PDO, pdo_sqlite, Phar, posix, Reflection, session, SimpleXML, SPL, sqlite3, standard, tokenizer, xml, xmlreader, xmlwriter, zip, zlib

### png (libpng 1.6.2)

* homepage: http://www.libpng.org/pub/png/libpng.html
* license: zlib
* provides: libpng16.a
* dependencies: *libz.dylib*

### snappy (Snappy 1.1.0)

* homepage: https://code.google.com/p/snappy/
* license: New BSD
* provides: libsnappy.a
* dependencies: none

### tiff (LibTIFF 4.0.3)

* homepage: http://www.remotesensing.org/libtiff/
* license: MIT-style
* provides: libtiff.a
* dependencies: *libz.dylib*

### webp (libwebp 0.3.1)

* homepage: https://developers.google.com/speed/webp/ https://code.google.com/p/webp/
* license: New BSD
* provides: libwebp.a
* dependencies: none

### xz (XZ Utils / liblzma 5.0.4)

* homepage: http://tukaani.org/xz/
* license: public domain (liblzma), some parts of XZ Utils are differnt
* provides: liblzma.a
* dependencies: none

### zxing (ZXing 2.2)

* homepage: https://code.google.com/p/zxing/
* license: Apache 2.0
* provides: libzxing.a
* dependencies: *libiconv.dylib*, *libstdc++.6.dylib*
