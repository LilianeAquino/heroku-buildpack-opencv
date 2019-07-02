#!/bin/bash

#export VERSION=$(shell echo `git describe --tags`)
export VERSION=0.0.1

export BUILD_PATH=/tmp
export OUT_PATH=/app/vendor/opencv
export PKG_CONFIG_PATH=$OUT_PATH/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=$OUT_PATH/bin:$PATH

rm -Rf $OUT_PATH

cd $BUILD_PATH

curl https://cmake.org/files/v3.5/cmake-3.5.1.tar.gz -o cmake.tar.gz
tar -xvzf cmake.tar.gz
cd cmake-3.5.1
./bootstrap
make

cd $BUILD_PATH

curl -L http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/3.4.3/opencv-3.4.3.zip/download -o opencv.zip
unzip opencv.zip
cd opencv-3.4.3
mkdir release
cd release
/tmp/cmake-3.5.1/bin/cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$OUT_PATH ..
make
make install

cd $OUT_PATH

tar -cvzf opencv-build-$(VERSION).tar.gz ./
curl --ftp-create-dirs -T opencv-build-$(VERSION).tgz -u $(FTP_USER):$(FTP_PASSWORD) ftp://void.cc/