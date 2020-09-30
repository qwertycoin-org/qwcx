# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    VAGRANT_BUILD_FOLDER = "/tmp/build_folder"
    VAGRANT_SYNCED_FOLDER = "/tmp/synced_folder"

    config.vm.define "linux" do |linux|
        linux.vm.hostname = "linux"
        linux.vm.box = "bento/ubuntu-16.04"
        linux.vm.box_check_update = false

        linux.vm.provision "bootstrap",
            type: "shell",
            privileged: false,
            run: "once",
            path: "scripts/ci/linux.sh"

        linux.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_TOOLCHAIN_FILE=\"#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/gcc-5-cxx14-c11.cmake \
                  -DQT5_DOWNLOAD_VERSION=5.15.0 \
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
            cmake --build . --config Release --target package
        SHELL
    end

    config.vm.define "linux_android" do |linux_android|
        linux_android.vm.hostname = "linux-android"
        linux_android.vm.box = "bento/ubuntu-16.04"
        linux_android.vm.box_check_update = false

        linux_android.vm.provision "bootstrap",
            type: "shell",
            privileged: false,
            run: "once",
            path: "scripts/ci/linux_android.sh"

        linux_android.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            QT_VERSION=5.15.0
            QT_DIR="\"#{VAGRANT_BUILD_FOLDER}\"/Qt5/$QT_VERSION/android"

            export PATH="$QT_DIR/bin:$PATH"

            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCMAKE_FIND_ROOT_PATH=$QT_DIR \
                  -DCMAKE_PROGRAM_PATH=$QT_DIR/bin \
                  -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
                  -DANDROID_ABI:STRING=x86 \
                  -DANDROID_BUILD_ABI_arm64-v8a:BOOL=ON \
                  -DANDROID_BUILD_ABI_armeabi-v7a:BOOL=ON \
                  -DANDROID_BUILD_ABI_x86:BOOL=ON \
                  -DANDROID_BUILD_ABI_x86_64:BOOL=OFF \
                  -DANDROID_NATIVE_API_LEVEL:STRING=21 \
                  -DANDROID_NDK=$ANDROID_NDK \
                  -DANDROID_PLATFORM=android-21 \
                  -DANDROID_SDK=$ANDROID_SDK \
                  -DANDROID_SDK_PLATFORM=android-21 \
                  -DANDROID_STL=c++_shared \
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
            cmake --build . --config Release --target package
        SHELL
    end

    config.vm.define "win32" do |win32|
        win32.vm.hostname = "win32"
        win32.vm.box = "gusztavvargadr/windows-10-enterprise"
        win32.vm.box_check_update = false

        win32.vm.provision "bootstrap",
            type: "shell",
            privileged: true,
            run: "once",
            path: "scripts/ci/win32.ps1"

        win32.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cmake -G "Visual Studio 16 2019" \
                  -A Win32 \
                  -DCMAKE_TOOLCHAIN_FILE=\"C:#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/vs-16-2019-cxx17.cmake \
                  -DQT5_DOWNLOAD_VERSION="5.14.1" \
                  -B \"C:#{VAGRANT_BUILD_FOLDER}\" \
                  -S \"C:#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        win32.vm.provision "build", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release --target ALL_BUILD
        SHELL

        win32.vm.provision "check", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            ctest -C Release
        SHELL

        win32.vm.provision "deploy", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release --target package
        SHELL
    end

    config.vm.define "win64" do |win64|
        win64.vm.hostname = "win64"
        win64.vm.box = "gusztavvargadr/windows-10-enterprise"
        win64.vm.box_check_update = false

        win64.vm.provision "bootstrap",
            type: "shell",
            privileged: true,
            run: "once",
            path: "scripts/ci/win64.ps1"

        win64.vm.provision "configure", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cmake -G "Visual Studio 16 2019" \
                  -A Win64 \
                  -DCMAKE_TOOLCHAIN_FILE=\"C:#{VAGRANT_SYNCED_FOLDER}\"/cmake/polly/vs-16-2019-win64-cxx17.cmake \
                  -DQT5_DOWNLOAD_VERSION="5.14.1" \
                  -B \"C:#{VAGRANT_BUILD_FOLDER}\" \
                  -S \"C:#{VAGRANT_SYNCED_FOLDER}\"
        SHELL

        win64.vm.provision "build", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release --target ALL_BUILD
        SHELL

        win64.vm.provision "check", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            ctest -C Release
        SHELL

        win64.vm.provision "deploy", type: "shell", privileged: false, run: "never", inline: <<-SHELL
            cd \"C:#{VAGRANT_BUILD_FOLDER}\"
            cmake --build . --config Release --target package
        SHELL
    end

    config.vm.synced_folder ".", "#{VAGRANT_SYNCED_FOLDER}"

    config.vm.provider "virtualbox" do |v|
        v.gui = false
        v.cpus = 2
        v.memory = "4096"
    end
end
