#!/bin/sh

sudo apt update
sudo apt install -y build-essential unzip

echo "Installing JDK 8..."
sudo apt install -y lib32z1 openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
echo "Done.\n"

echo "Installing latest CMake..."
CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh
wget -O /tmp/cmake.sh -nv $CMAKE_URL
sudo sh /tmp/cmake.sh --prefix=/usr --skip-license
echo "Done.\n"

echo "Installing Android SDK..."
mkdir -p "$HOME/.android"
ANDROID_SDK_URL=https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
wget -O "$HOME/.android/sdk-tools-linux-4333796.zip" -q "$ANDROID_SDK_URL"
unzip -qq "$HOME/.android/sdk-tools-linux-4333796.zip" -d "$HOME/.android/sdk"
export ANDROID_SDK="$HOME/.android/sdk"
echo "Done.\n"

echo "Installing Android NDK and other packages..."
cd "$ANDROID_SDK/tools/bin"
yes | ./sdkmanager --licenses 2>&1 > /dev/null
yes | ./sdkmanager --update 2>&1 > /dev/null
yes | ./sdkmanager --install "build-tools;28.0.3" 2>&1 > /dev/null
yes | ./sdkmanager --install "ndk;21.0.6113669" 2>&1 > /dev/null
yes | ./sdkmanager --install "platforms;android-28" 2>&1 > /dev/null
yes | ./sdkmanager --install "platform-tools" "tools" 2>&1 > /dev/null
export ANDROID_NDK="$ANDROID_SDK/ndk/21.0.6113669"
echo "Done.\n"

echo "Generating debug.keystore for Android"
keytool -genkey -v \
    -keystore "$HOME/.android/debug.keystore" \
    -alias androiddebugkey \
    -storepass android \
    -keypass android \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000 \
    -dname "CN=Android Debug,O=Android,C=US"
echo "Done.\n"

echo "Saving environment variables..."
echo "\nexport JAVA_HOME=$JAVA_HOME" >> $HOME/.profile
echo "\nexport ANDROID_SDK=$ANDROID_SDK" >> $HOME/.profile
echo "\nexport ANDROID_NDK=$ANDROID_NDK" >> $HOME/.profile
echo "Done.\n"
