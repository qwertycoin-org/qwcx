# Executable

set(QWCX_TARGET_DISPLAY_NAME "${PROJECT_DISPLAY_NAME}")
set(QWCX_TARGET_NAME "${PROJECT_NAME}")
set(QWCX_TARGET_NAME_CAMELCASE "${PROJECT_NAME_CAMELCASE}")
set(QWCX_TARGET_NAME_LOWERCASE "${PROJECT_NAME_LOWERCASE}")
set(QWCX_TARGET_VERSION "${PROJECT_VERSION}")
set(QWCX_TARGET_VENDOR_DOMAIN "qwertycoin.org")
set(QWCX_TARGET_VENDOR_DOMAIN_REVERSED "org.qwertycoin")
set(QWCX_TARGET_VENDOR_NAME "Qwertycoin")

if(DEVELOPER_BUILD)
    set(QWCX_TARGET_DEVELOPER_BUILD ON)
else()
    set(QWCX_TARGET_DEVELOPER_BUILD OFF)
endif()

set(TARGET_NAME "${PROJECT_NAME_CAMELCASE}Executable")

qt5_add_big_resources(
    TARGET_QRC
    "${CMAKE_CURRENT_LIST_DIR}/resources/resources.qrc"
)

qtquick_compiler_add_resources(
    TARGET_COMPILED_QRC
    "${CMAKE_CURRENT_LIST_DIR}/qml/main.qrc"
)

set(TARGET_SRC
    PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/bin/applicationconstants.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/bin/applicationconstants.h"
    "${CMAKE_CURRENT_LIST_DIR}/bin/applicationdelegate.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/bin/applicationdelegate.h"
    "${CMAKE_CURRENT_LIST_DIR}/bin/main.cpp"
    ${TARGET_QRC}
    ${TARGET_COMPILED_QRC}
)

set(TARGET_INCLUDE_DIRS
    PRIVATE
    "${Qt5Core_INCLUDE_DIRS}"
    "${Qt5Gui_INCLUDE_DIRS}"
    "${Qt5Qml_INCLUDE_DIRS}"
    "${Qt5QuickControls2_INCLUDE_DIRS}"
    "${Qt5Svg_INCLUDE_DIRS}"
    "${Qt5Widgets_INCLUDE_DIRS}"
    "${QWCX_INCLUDE_DIRS}"
)
list(REMOVE_DUPLICATES TARGET_INCLUDE_DIRS)

set(TARGET_LINK_LIBS
    PRIVATE
    Qt5::Core
    Qt5::Gui
    Qt5::Qml
    Qt5::QuickControls2
    Qt5::Svg
    Qt5::Widgets
    QWCXFramework::Controls
    QWCXFramework::Controls::Fluid
    QWCXFramework::Core
    QWCXFramework::Global
)

set(TARGET_COMPILE_DEFS
    PRIVATE
    -DQT_NO_CAST_FROM_ASCII
    -DQT_NO_CAST_TO_ASCII
    -DQT_NO_CAST_FROM_BYTEARRAY
    -DQT_NO_URL_CAST_FROM_STRING
)
if(QWCX_TARGET_DEVELOPER_BUILD)
    list(APPEND TARGET_COMPILE_DEFS -DQT_QML_DEBUG)
endif()

if(ANDROID)
    add_library(${TARGET_NAME} MODULE)
else()
    add_executable(${TARGET_NAME} WIN32 MACOSX_BUNDLE)
endif()
target_sources(${TARGET_NAME} ${TARGET_SRC})
target_include_directories(${TARGET_NAME} ${TARGET_INCLUDE_DIRS})
target_link_libraries(${TARGET_NAME} ${TARGET_LINK_LIBS})
target_compile_definitions(${TARGET_NAME} ${TARGET_COMPILE_DEFS})

# Add application constants as preprocessor definitions (ONLY for a single file!)
set_property(
    SOURCE "${CMAKE_CURRENT_LIST_DIR}/bin/applicationconstants.cpp"
    APPEND PROPERTY COMPILE_DEFINITIONS
    QWCX_APPLICATION_DISPLAY_NAME=\"${QWCX_TARGET_DISPLAY_NAME}\"
    QWCX_APPLICATION_NAME=\"${QWCX_TARGET_DISPLAY_NAME}\"
    QWCX_APPLICATION_VERSION=\"${QWCX_TARGET_VERSION}\"
    QWCX_ORGANIZATION_DOMAIN=\"${QWCX_TARGET_VENDOR_DOMAIN}\"
    QWCX_ORGANIZATION_NAME=\"${QWCX_TARGET_VENDOR_NAME}\"
)

if(PROJECT_OS_ANDROID)
    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_NAME_CAMELCASE}"
        # Not having this flag set will cause the executable to have main()
        # hidden and it can thus no longer be loaded through dlopen().
        C_VISIBILITY_PRESET "default"
        CXX_VISIBILITY_PRESET "default"
    )

    if(Qt5_androiddeployqt_FOUND AND (NOT ${PROJECT_NAME}-MultiAbiBuild))
        if(DEFINED ENV{JAVA_HOME})
            set(JAVA_HOME $ENV{JAVA_HOME} CACHE INTERNAL "Saved JAVA_HOME variable")
        endif()
        if(JAVA_HOME)
            set(android_deploy_qt_jdk "--jdk ${JAVA_HOME}")
        endif()

        if(ANDROID_SDK_PLATFORM)
            set(android_deploy_qt_platform "--android-platform ${ANDROID_SDK_PLATFORM}")
        endif()

        # This generator expression shouldn't be used outside of custom target declarations!
        set(ANDROID_DEPLOY_QT "$<TARGET_FILE:Qt5::androiddeployqt>")

#        add_custom_target(apk_unsigned
#            COMMAND ${CMAKE_COMMAND} -E env JAVA_HOME=${JAVA_HOME}
#                ${ANDROID_DEPLOY_QT}
#                --input "${CMAKE_BINARY_DIR}/android_deployment_settings.json"
#                --output "${CMAKE_BINARY_DIR}/android-build"
#                --apk "${CMAKE_BINARY_DIR}/android-build/${PROJECT_NAME}.apk"
#                --release
#                ${android_deploy_qt_platform}
#                ${android_deploy_qt_jdk}
#            VERBATIM
#        )

#        add_custom_target(aab_unsigned
#            COMMAND ${CMAKE_COMMAND} -E env JAVA_HOME=${JAVA_HOME}
#                ${ANDROID_DEPLOY_QT}
#                --input "${CMAKE_BINARY_DIR}/android_deployment_settings.json"
#                --output "${CMAKE_BINARY_DIR}/android-build"
#                --apk "${CMAKE_BINARY_DIR}/android-build/${PROJECT_NAME}.apk"
#                --aab
#                --release
#                ${android_deploy_qt_platform}
#                ${android_deploy_qt_jdk}
#            COMMAND ${CMAKE_COMMAND} -E copy
#                "${CMAKE_BINARY_DIR}/android-build/build/outputs/bundle/release/android-build-release.aab"
#                "${CMAKE_BINARY_DIR}/android-build/${PROJECT_NAME}.aab"
#            VERBATIM
#        )

        set(ANDROID_APK_IN "${CMAKE_BINARY_DIR}/android-build/${PROJECT_NAME}.apk")
        set(ANDROID_APK_OUT "${CMAKE_BINARY_DIR}/dist/${PROJECT_PACKAGE_FILE_NAME}.apk")
        set(ANDROID_AAB_IN "${CMAKE_BINARY_DIR}/android-build/build/outputs/bundle/debug/android-build-debug.aab")
        set(ANDROID_AAB_OUT "${CMAKE_BINARY_DIR}/dist/${PROJECT_PACKAGE_FILE_NAME}.aab")
        set(ANDROID_PACKAGE_DEPENDENCIES ${TARGET_NAME} apk aab)
        add_custom_target(
            package
            DEPENDS ${ANDROID_PACKAGE_DEPENDENCIES}
            COMMAND ${CMAKE_COMMAND} -E copy "${ANDROID_APK_IN}" "${ANDROID_APK_OUT}"
            COMMAND ${CMAKE_COMMAND} -E copy "${ANDROID_AAB_IN}" "${ANDROID_AAB_OUT}"
            VERBATIM
        )
        unset(ANDROID_APK_IN)
        unset(ANDROID_APK_OUT)
        unset(ANDROID_AAB_IN)
        unset(ANDROID_AAB_OUT)
        unset(ANDROID_PACKAGE_DEPENDENCIES)
    endif()
elseif(PROJECT_OS_LINUX OR PROJECT_OS_POSIX)
    set(LINUX_APPDIR "${CMAKE_CURRENT_BINARY_DIR}/AppDir")

    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_NAME_LOWERCASE}"
        RUNTIME_OUTPUT_DIRECTORY "AppDir/usr/bin"
    )

    set(DESKTOP_ENTRY_IN "${CMAKE_CURRENT_BINARY_DIR}/${QWCX_TARGET_NAME_LOWERCASE}.desktop")
    set(DESKTOP_ENTRY_OUT "${LINUX_APPDIR}/usr/share/applications/${QWCX_TARGET_NAME_LOWERCASE}.desktop")
    set(ICON_IN "${CMAKE_CURRENT_LIST_DIR}/resources/platforms/linux/icon.png")
    set(ICON_OUT "${LINUX_APPDIR}/usr/share/icons/hicolor/256x256/apps/${QWCX_TARGET_NAME_LOWERCASE}.png")
    configure_file(
        "${CMAKE_CURRENT_LIST_DIR}/resources/platforms/linux/spec.desktop.in"
        "${DESKTOP_ENTRY_IN}"
        @ONLY
        NEWLINE_STYLE UNIX
    )
    add_custom_command(
        TARGET ${TARGET_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Created 'lib' directory."
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR}/usr/lib"
        COMMAND ${CMAKE_COMMAND} -E echo "Created 'plugins' directory."
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR}/usr/plugins"
        COMMAND ${CMAKE_COMMAND} -E echo "Created 'share' directory."
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR}/usr/share"
        COMMAND ${CMAKE_COMMAND} -E echo "Created desktop entry in 'share/applications' directory."
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR}/usr/share/applications"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${DESKTOP_ENTRY_IN} ${DESKTOP_ENTRY_OUT}
        COMMAND ${CMAKE_COMMAND} -E echo "Copied app icon to 'share/icon/...' directory."
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR}/usr/share/icons/hicolor/256x256/apps"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ICON_IN} ${ICON_OUT}
        COMMENT "Creating/updating application AppDir contents"
    )
    unset(DESKTOP_ENTRY_IN)
    unset(DESKTOP_ENTRY_OUT)
    unset(ICON_IN)
    unset(ICON_OUT)

    set(APPIMAGE_IN_REGEXP "QWCX-*.AppImage")
    set(APPIMAGE_OUT "${CMAKE_BINARY_DIR}/dist/${PROJECT_PACKAGE_FILE_NAME}.AppImage")
    add_custom_target(
        package
        DEPENDS ${TARGET_NAME}
        COMMAND ${CMAKE_COMMAND} -E env Qt5_DIR=${Qt5_DIR}
            ${QT_INSTALL_BINS}/linuxdeployqt
            ${LINUX_APPDIR}/usr/share/applications/${QWCX_TARGET_NAME_LOWERCASE}.desktop
            -always-overwrite
            -appimage
            -no-copy-copyright-files
            -qmake=${QT_INSTALL_BINS}/qmake
            -qmldir=${CMAKE_CURRENT_SOURCE_DIR}/qml
            -qmlimport=${QT_INSTALL_BINS}/../qml
        COMMAND ${CMAKE_COMMAND} -E echo "Copied *.AppImage file to 'dist' directory."
        COMMAND ${CMAKE_COMMAND} -E env Qt5_DIR=${Qt5_DIR}
            find ${CMAKE_CURRENT_BINARY_DIR}
            -type f
            -iname "${APPIMAGE_IN_REGEXP}"
            -exec mv {} ${APPIMAGE_OUT} \;
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        VERBATIM
    )
    unset(APPIMAGE_IN_REGEXP)
    unset(APPIMAGE_OUT)
elseif(PROJECT_OS_MACOS)
    set(MACOSX_BUNDLE_ICON_FILE_NAME "icon.icns")

    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_DISPLAY_NAME}"
        MACOSX_BUNDLE_BUNDLE_NAME "${QWCX_TARGET_DISPLAY_NAME}"
        MACOSX_BUNDLE_EXECUTABLE_NAME "${QWCX_TARGET_DISPLAY_NAME}"
        MACOSX_BUNDLE_BUNDLE_VERSION "${QWCX_TARGET_VERSION}"
        MACOSX_BUNDLE_SHORT_VERSION_STRING "${QWCX_TARGET_VERSION}"
        MACOSX_BUNDLE_LONG_VERSION_STRING "${QWCX_TARGET_VERSION}"
        MACOSX_BUNDLE_GUI_IDENTIFIER "${QWCX_TARGET_VENDOR_DOMAIN_REVERSED}.${QWCX_TARGET_NAME_LOWERCASE}"
        MACOSX_BUNDLE_INFO_STRING "" # Don't use. Depricated in Mac OS X 10.5 and newer.
        MACOSX_BUNDLE_ICON_FILE "${MACOSX_BUNDLE_ICON_FILE_NAME}"
        MACOSX_BUNDLE_COPYRIGHT "(c) 2020 ${QWCX_TARGET_VENDOR_NAME}"
        MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_LIST_DIR}/resources/platforms/macos/Info.plist.in"
    )

    # Deploy application icon
    set(ICON_IN "${CMAKE_CURRENT_LIST_DIR}/resources/platforms/macos/${MACOSX_BUNDLE_ICON_FILE_NAME}")
    set(ICON_OUT "$<TARGET_FILE_DIR:${TARGET_NAME}>/../Resources/${MACOSX_BUNDLE_ICON_FILE_NAME}")
    add_custom_command(
        TARGET ${TARGET_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Created *.app/Contents/Resources directory."
        COMMAND ${CMAKE_COMMAND} -E make_directory "$<TARGET_FILE_DIR:${TARGET_NAME}>/../Resources"
        COMMAND ${CMAKE_COMMAND} -E echo "Copied the .icns file into *.app/Contents/Resources dir."
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ICON_IN} ${ICON_OUT}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Copying icon.icns into ${QWCX_TARGET_DISPLAY_NAME}.app/Contents/Resources"
    )
    unset(ICON_IN)
    unset(ICON_OUT)

    set(MACDMG_IN "${CMAKE_CURRENT_BINARY_DIR}/${QWCX_TARGET_DISPLAY_NAME}.dmg")
    set(MACDMG_OUT "${CMAKE_BINARY_DIR}/dist/${PROJECT_PACKAGE_FILE_NAME}.dmg")
    add_custom_target(
        package
        DEPENDS ${TARGET_NAME}
        COMMAND ${CMAKE_COMMAND} -E env Qt5_DIR=${Qt5_DIR}
            ${QT_INSTALL_BINS}/macdeployqt
            ./${QWCX_TARGET_DISPLAY_NAME}.app
            -dmg
            -qmldir=${CMAKE_CURRENT_SOURCE_DIR}/qml
            -qmlimport=${QT_INSTALL_BINS}/../qml
            -always-overwrite
            -appstore-compliant
        COMMAND ${CMAKE_COMMAND} -E echo "Copied *.dmg file to 'dist' directory."
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${MACDMG_IN} ${MACDMG_OUT}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        VERBATIM
    )
    unset(MACDMG_IN)
    unset(MACDMG_OUT)
elseif(PROJECT_OS_WINDOWS) # Windows
    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_DISPLAY_NAME}"
    )

    foreach(_config_type ${CMAKE_CONFIGURATION_TYPES})
        if("${_config_type}" STREQUAL "Debug")
            set(_assumed_binaries_type "--debug")
        else()
            set(_assumed_binaries_type "--release")
        endif()

        string(TOLOWER "${_config_type}" _config_type_lowercase)
        string(TOUPPER "${_config_type}" _config_type_uppercase)
        set(_output_directory_prefix "${CMAKE_CURRENT_BINARY_DIR}/${_config_type}")

        set_target_properties(
            ${TARGET_NAME}
            PROPERTIES
            ARCHIVE_OUTPUT_DIRECTORY_${_config_type_uppercase} "${_output_directory_prefix}/lib"
            LIBRARY_OUTPUT_DIRECTORY_${_config_type_uppercase} "${_output_directory_prefix}/lib"
            RUNTIME_OUTPUT_DIRECTORY_${_config_type_uppercase} "${_output_directory_prefix}/bin"
        )

        add_custom_target(
            package-${_config_type_lowercase}
            DEPENDS ${TARGET_NAME}
            COMMAND ${CMAKE_COMMAND} -E env Qt5_DIR="${Qt5_DIR}"
                ${QT_INSTALL_BINS}/windeployqt
                ${_assumed_binaries_type}
                --force
                --qmldir=${CMAKE_CURRENT_SOURCE_DIR}/qml
                --qmlimport=${QT_INSTALL_BINS}/../qml
                --compiler-runtime
                $<TARGET_FILE:${TARGET_NAME}>
            COMMAND powershell Compress-Archive
                -Path "${_output_directory_prefix}/*"
                -DestinationPath "${CMAKE_BINARY_DIR}/dist/${PROJECT_PACKAGE_FILE_NAME}.zip"
                -CompressionLevel Optimal
                -Force
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${_config_type}"
            VERBATIM
        )

        unset(_assumed_binaries_type)
        unset(_config_type_lowercase)
        unset(_config_type_uppercase)
        unset(_output_directory_prefix)
    endforeach()

    add_custom_target(package DEPENDS ${TARGET_NAME} package-release)
else() # unknown OS
    message(ERROR "Unknown (or unsupported) OS! Can't continue! Sorry.")
endif()
