#!/bin/bash
set -e

apt-get update --fix-missing || true

apt-get install -y --fix-missing \
    build-essential pkg-config \
    libopencv-dev \
    libavcodec-dev libavformat-dev libswscale-dev

# Bookworm splits contrib modules out; Bullseye bundles them into libopencv-dev.
apt-get install -y libopencv-contrib-dev || true
