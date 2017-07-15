#!/bin/bash

export PATH=$PATH:/usr/lib/nvidia-cuda-toolkit/bin

if [ `uname` == Darwin ]; then
    export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib
    MAKE_JOBS=$(sysctl -n hw.ncpu)
fi

if [ `uname` == Linux ]; then
    MAKE_JOBS=$CPU_COUNT
fi

$PYTHON configure.py \
        -verbose \
        -confirm-license \
        --assume-shared \
        -opengl desktop \
        -gstreamer \
        -no-compile-examples \
        -qt-pcre \
        -qt-xcb \
        -qt-freetype \
        -qt-libjpeg \
        -qt-libpng \
        -qt-zlib \
        -opensource /
        -q $PREFIX/bin/qmake-qt5

make -j $MAKE_JOBS
make install
