#!/bin/sh

sudo apt update
sudo apt install -y build-essential gcc-8 g++-8 libfontconfig1 libgl1-mesa-dev mesa-common-dev
sudo apt install -y libpulse0 libpulse-dev # Qt Multimedia

echo "Installing latest CMake..."
CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh
wget -O /tmp/cmake.sh -nv $CMAKE_URL
sudo sh /tmp/cmake.sh --prefix=/usr --skip-license
