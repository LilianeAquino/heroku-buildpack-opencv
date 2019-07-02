#!/bin/bash

#export VERSION=$(shell echo `git describe --tags`)
export VERSION=0.0.1

export BUILD_PATH=/tmp
export OUT_PATH=/app/vendor/opencv
export PKG_CONFIG_PATH=$OUT_PATH/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=$OUT_PATH/bin:$PATH

rm -Rf $OUT_PATH

cd $BUILD_PATH

curl https://cmake.org/files/v3.1/cmake-3.1.1.tar.gz -o cmake.tar.gz
tar -xvzf cmake.tar.gz
cd cmake-3.1.1
./bootstrap
make

cd $BUILD_PATH

curl -L http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.10/opencv-2.4.10.zip/download -o opencv.zip
unzip opencv.zip
cd opencv-2.4.10
mkdir release
cd release
/tmp/cmake-3.1.1/bin/cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$OUT_PATH ..
make
make install

cd $OUT_PATH

tar -cvzf opencv-build-$(VERSION).tar.gz ./
curl --ftp-create-dirs -T opencv-build-$(VERSION).tgz -u $(FTP_USER):$(FTP_PASSWORD) ftp://void.cc/