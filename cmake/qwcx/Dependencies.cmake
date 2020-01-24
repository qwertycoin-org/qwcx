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
