#!/bin/bash
set -e

OPENCV_VERSION="${OPENCV_VERSION:-4.11.0}"
TMP_DIR="/tmp/gocv_opencv"

apt-get update --fix-missing || true
apt-get install -y --fix-missing \
    build-essential cmake git pkg-config unzip \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev \
    libv4l-dev libatlas-base-dev gfortran libtbb-dev \
    libfreetype6-dev libharfbuzz-dev libx264-dev libvpx-dev \
    libnlopt-dev coreutils tar

rm -rf "$TMP_DIR" && mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

curl -Lo opencv.zip "https://github.com/opencv/opencv/archive/refs/tags/${OPENCV_VERSION}.zip"
unzip -q opencv.zip
curl -Lo opencv_contrib.zip "https://github.com/opencv/opencv_contrib/archive/refs/tags/${OPENCV_VERSION}.zip"
unzip -q opencv_contrib.zip
rm opencv.zip opencv_contrib.zip

mkdir -p "${TMP_DIR}/opencv-${OPENCV_VERSION}/build"
cd "${TMP_DIR}/opencv-${OPENCV_VERSION}/build"

CMAKE_FLAGS=(
    -D CMAKE_BUILD_TYPE=RELEASE
    -D CMAKE_INSTALL_PREFIX=/usr/local
    -D BUILD_SHARED_LIBS=OFF
    -D OPENCV_EXTRA_MODULES_PATH="${TMP_DIR}/opencv_contrib-${OPENCV_VERSION}/modules"
    -D BUILD_DOCS=OFF
    -D BUILD_EXAMPLES=OFF
    -D BUILD_TESTS=OFF
    -D BUILD_PERF_TESTS=OFF
    -D BUILD_opencv_java=OFF
    -D BUILD_opencv_python=OFF
    -D WITH_JASPER=OFF
    -D WITH_TBB=ON
    -D OPENCV_GENERATE_PKGCONFIG=ON
)

if [ "$(uname -m)" = "aarch64" ]; then
    CMAKE_FLAGS+=(-D ENABLE_NEON=ON)
fi

cmake "${CMAKE_FLAGS[@]}" ..
make -j"$(nproc)"
make install
ldconfig
