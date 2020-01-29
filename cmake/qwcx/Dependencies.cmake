if(ANDROID)
    set(ANDROID_BUNDLETOOL_VERSION "0.12.0")
    set(ANDROID_BUNDLETOOL_URL_PREFIX "https://github.com/google/bundletool/releases/download")
    set(ANDROID_BUNDLETOOL_URL "${ANDROID_BUNDLETOOL_URL_PREFIX}/${ANDROID_BUNDLETOOL_VERSION}/bundletool-all-${ANDROID_BUNDLETOOL_VERSION}.jar")
    set(ANDROID_BUNDLETOOL_JAR "${CMAKE_CURRENT_BINARY_DIR}/bundletool-all-0.12.0.jar")
    if(NOT EXISTS "${ANDROID_BUNDLETOOL_JAR}")
        message(STATUS "Downloading bundletool v${ANDROID_BUNDLETOOL_VERSION} to ${ANDROID_BUNDLETOOL_JAR}")
        file(DOWNLOAD "${ANDROID_BUNDLETOOL_URL}" "${ANDROID_BUNDLETOOL_JAR}" SHOW_PROGRESS)
        set(ANDROID_BUNDLETOOL_JAR "${ANDROID_BUNDLETOOL_JAR}" CACHE STRING "Android bundletool path" FORCE)
    endif()
endif()

# (optional) Download and unpack Qt5
if(DEFINED QT5_DOWNLOAD_VERSION)
    install_qt5(
        DOWNLOAD_VERSION "${QT5_DOWNLOAD_VERSION}"
        INSTALL_PREFIX "${PROJECT_BINARY_DIR}/Qt5"
        PACKAGES qtbase qtdeclarative qtmultimedia qtquickcontrols2 qtsvg qttools
    )
    message(STATUS "Downloaded Qt v${QT5_DOWNLOAD_VERSION}.")
endif()

set(Qt5_COMPONENTS Core Gui Multimedia Network Qml Quick QuickCompiler QuickControls2 Svg Widgets)
include(external/Qt5)

include(external/ZXing)
