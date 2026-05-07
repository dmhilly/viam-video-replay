#!/bin/bash
set -e

sudo apt-get update --fix-missing || true

sudo apt-get install -y --fix-missing \
    libopencv-dev \
    libavcodec-extra libavformat-dev libswscale-dev

sudo apt-get install -y libopencv-contrib-dev || true
