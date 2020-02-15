#!/bin/sh

sudo apt update
sudo apt install -y build-essential gcc-5 g++-5 libfontconfig1 libglu1-mesa-dev mesa-common-dev
sudo apt install -y libpulse0 libpulse-dev # for Qt Multimedia
sudo apt install -y libgstreamer-plugins-base1.0-0 libasound2 # for Qt plugins (mediaservice)
sudo apt install -y libxkbcommon-x11-0 libxkbcommon-x11-dev # for Qt plugins (platforms)
sudo apt install -y libegl1-mesa libegl1-mesa-dev # for Qt platform plugins (xcbglintegrations)

echo "Installing latest CMake..."
CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh
wget -O /tmp/cmake.sh -nv $CMAKE_URL
sudo sh /tmp/cmake.sh --prefix=/usr --skip-license
