# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    VAGRANT_BUILD_FOLDER = "/tmp/build_folder"
    VAGRANT_SYNCED_FOLDER = "/tmp/synced_folder"

    config.vm.define "linux" do |linux|
        linux.vm.hostname = "linux"
        linux.vm.box = "bento/ubuntu-18.04"
        linux.vm.box_check_update = false

        linux.vm.provision "bootstrap", type: "shell", privileged: false, run: "once", inline: <<-SHELL
            sudo apt update
            sudo apt install -y build-essential gcc-8 g++-8 libfontconfig1 libgl1-mesa-dev mesa-common-dev
            sudo apt install -y libpulse0 libpulse-dev # Qt Multimedia

            echo "Installing latest CMake..."
            CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh
            wget -O /tmp/cmake.sh -nv $CMAKE_URL
            sudo sh /tmp/cmake.sh --prefix=/usr --skip-license
        SHELL

        linux.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_TOOLCHAIN_FILE=\"#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/gcc-8-cxx17.cmake \
                  -DQT5_DOWNLOAD_VERSION=5.14.0 \
                  -B \"#{VAGRANT_BUILD_FOLDER}\" \
                  -S \"#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        linux.vm.provision "build", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release
        SHELL

        linux.vm.provision "check", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            ctest -C Release
        SHELL

        linux.vm.provision "deploy", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            # TODO: cmake --build . --config Release --target package
        SHELL
    end

    config.vm.define "linux_android" do |linux_android|
        linux_android.vm.hostname = "linux-android"
        linux_android.vm.box = "bento/ubuntu-18.04"
        linux_android.vm.box_check_update = false

        linux_android.vm.provision "bootstrap", type: "shell", privileged: false, run: "once", inline: <<-SHELL
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
            yes | ./sdkmanager --install "platforms;android-29" 2>&1 > /dev/null
            yes | ./sdkmanager --install "platform-tools" "tools" 2>&1 > /dev/null
            export ANDROID_NDK="$ANDROID_SDK/ndk/21.0.6113669"
            echo "Done.\n"

            echo "Saving environment variables..."
            echo "\nexport JAVA_HOME=$JAVA_HOME" >> $HOME/.profile
            echo "\nexport ANDROID_SDK=$ANDROID_SDK" >> $HOME/.profile
            echo "\nexport ANDROID_NDK=$ANDROID_NDK" >> $HOME/.profile
            echo "Done.\n"
        SHELL

        linux_android.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            QT_VERSION=5.14.1
            QT_DIR="\"#{VAGRANT_BUILD_FOLDER}\"/Qt5/$QT_VERSION/android"

            export PATH="$QT_DIR/bin:$PATH"

            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_FIND_ROOT_PATH=$QT_DIR \
                  -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
                  -DANDROID_ABI:STRING=x86_64 \
                  -DANDROID_BUILD_ABI_arm64-v8a:BOOL=ON \
                  -DANDROID_BUILD_ABI_armeabi-v7a:BOOL=ON \
                  -DANDROID_BUILD_ABI_x86:BOOL=ON \
                  -DANDROID_BUILD_ABI_x86_64:BOOL=ON \
                  -DANDROID_NATIVE_API_LEVEL:STRING=21 \
                  -DANDROID_NDK=$ANDROID_NDK \
                  -DANDROID_SDK=$ANDROID_SDK \
                  -DANDROID_STL=c++_shared \
                  -DANDROID_PLATFORM=android-21 \
                  -DANDROID_TOOLCHAIN=clang \
                  -DQT5_DOWNLOAD_VERSION=$QT_VERSION \
                  -B \"#{VAGRANT_BUILD_FOLDER}\" \
                  -S \"#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        linux_android.vm.provision "build", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release --target all
        SHELL

        linux_android.vm.provision "check", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            ctest -C Release
        SHELL

        linux_android.vm.provision "deploy", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release --target aab_unsigned
        SHELL
    end

    config.vm.define "win32" do |win32|
        win32.vm.hostname = "win32"
        win32.vm.box = "gusztavvargadr/windows-10"
        win32.vm.box_check_update = false

        win32.vm.provision "bootstrap", type: "shell", privileged: true, run: "once", inline: <<-SHELL
            choco upgrade -y chocolatey

            choco install -y cmake
            choco install -y git
            choco install -y visualstudio2019buildtools
            choco install -y visualstudio2019-workload-vctools --package-parameters "--includeRecommended"
            choco install -y --execution-timeout=0 visualstudio2019-workload-manageddesktop

            Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
            Install-Module -Name Pscx -MinimumVersion 3.2.2 -AllowClobber

            Import-Module Pscx
            Invoke-BatchFile "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars32.bat"
            $env:Path = "C:\\Program Files\\CMake\\bin;$env:Path"
            [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
        SHELL

        win32.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_TOOLCHAIN_FILE=\"C:#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/vs-16-2019-cxx17.cmake \
                  -DQT5_DOWNLOAD_VERSION="5.14.1" \
                  -B \"C:#{VAGRANT_BUILD_FOLDER}\" \
                  -S \"C:#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        win32.vm.provision "build", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release
        SHELL

        win32.vm.provision "check", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            # TODO: ctest -C Release
        SHELL

        win32.vm.provision "deploy", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
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
