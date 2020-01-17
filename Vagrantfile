# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    VAGRANT_BUILD_FOLDER = "/tmp/build_folder"
    VAGRANT_SYNCED_FOLDER = "/tmp/synced_folder"

    config.vm.define "linux" do |linux|
        linux.vm.hostname = "linux"
        linux.vm.box = "bento/ubuntu-18.04"
        linux.vm.box_check_update = false

        linux.vm.provision "bootstrap", type: "shell", run: "once", inline: <<-SHELL
            apt update
            apt install -y build-essential gcc-8 g++-8 libfontconfig1 libgl1-mesa-dev mesa-common-dev
            apt install -y libpulse0 libpulse-dev # Qt Multimedia

            echo "Installing latest CMake..."
            wget -O /tmp/cmake.sh -q https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh
            sh /tmp/cmake.sh --prefix=/usr --skip-license
        SHELL

        linux.vm.provision "configure", type: "shell", run: "never", inline: <<-SHELL
            mkdir -p \"#{VAGRANT_BUILD_FOLDER}\" && cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_TOOLCHAIN_FILE=\"#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/gcc-8-cxx17.cmake \
                  -DQT5_DOWNLOAD_VERSION=5.14.0 \
                  \"#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        linux.vm.provision "build", type: "shell", run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release
        SHELL

        linux.vm.provision "check", type: "shell", run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            ctest -C Release
        SHELL

        linux.vm.provision "deploy", type: "shell", run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            # TODO: cmake --build . --config Release --target package
        SHELL
    end

    config.vm.define "linux_android" do |linux_android|
        linux_android.vm.hostname = "linux-android"
        linux_android.vm.box = "bento/ubuntu-18.04"
        linux_android.vm.box_check_update = false

        linux_android.vm.provision "bootstrap", type: "shell", run: "once", inline: <<-SHELL
            apt update
            apt install -y build-essential unzip

            echo "Installing latest CMake..."
            wget -O /tmp/cmake.sh -q https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh
            sh /tmp/cmake.sh --prefix=/usr --skip-license

            echo "Installing Android NDK..."
            mkdir -p "$HOME/.android"
            wget -O "$HOME/.android/android-ndk-r18b-linux-x86_64.zip" -q \
                    "https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip"
            unzip -qq "$HOME/.android/android-ndk-r18b-linux-x86_64.zip" -d "$HOME/.android"
        SHELL

        linux_android.vm.provision "configure", type: "shell", run: "never", inline: <<-SHELL
            export ANDROID_NDK_r18b="$HOME/.android/android-ndk-r18b"
            mkdir -p \"#{VAGRANT_BUILD_FOLDER}\" && cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_TOOLCHAIN_FILE=\"#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/android-ndk-r18b-api-21-x86-clang-libcxx.cmake \
                  -DANDROID_ABI:STRING=x86 \
                  -DANDROID_NATIVE_API_LEVEL:STRING=21 \
                  -DQT5_DOWNLOAD_VERSION=5.14.0 \
                  \"#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        linux_android.vm.provision "build", type: "shell", run: "never", inline: <<-SHELL
            export ANDROID_NDK_r18b="$HOME/.android/android-ndk-r18b"
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release
        SHELL

        linux_android.vm.provision "check", type: "shell", run: "never", inline: <<-SHELL
            export ANDROID_NDK_r18b="$HOME/.android/android-ndk-r18b"
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            ctest -C Release
        SHELL

        linux_android.vm.provision "deploy", type: "shell", run: "never", inline: <<-SHELL
            export ANDROID_NDK_r18b="$HOME/.android/android-ndk-r18b"
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            # TODO: cmake --build . --config Release --target package
        SHELL
    end

    config.vm.synced_folder ".", "#{VAGRANT_SYNCED_FOLDER}"

    config.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 2
        v.memory = "4096"
    end
end
