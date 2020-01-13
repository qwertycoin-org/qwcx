# ...
include(CMakeParseArguments)

# ...
include(ExternalProject)
set_directory_properties(PROPERTIES EP_BASE "${PROJECT_BINARY_DIR}/CMakeExternalProjects")

# ...
include(FetchContent)
set(FETCHCONTENT_BASE_DIR "${PROJECT_BINARY_DIR}/CMakeFetchContent" CACHE PATH "FetchContent" FORCE)

# ...
function(install_qt5)
    cmake_parse_arguments(PARSE_ARGV 0 "QT5" "" "DOWNLOAD_VERSION;INSTALL_PREFIX" "PACKAGES")

    # TODO: Validate QT5_DOWNLOAD_VERSION value.
    # TODO: Validate QT5_INSTALL_PREFIX value.
    # TODO: Validate QT5_PACKAGES value.

    get_filename_component(QT5_INSTALL_PREFIX "${QT5_INSTALL_PREFIX}" REALPATH)
    if(NOT EXISTS "${QT5_INSTALL_PREFIX}")
        message(STATUS "Created QT5_INSTALL_PREFIX dir ${QT5_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "${QT5_INSTALL_PREFIX}")
    endif()
    message(STATUS "Qt5 will be installed to ${QT5_INSTALL_PREFIX}")

    string(REPLACE "." "" QT5_DOWNLOAD_VERSION_DOTLESS "${QT5_DOWNLOAD_VERSION}")

    if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Linux")
        set(QT5_DOWNLOAD_URL_OS "linux_x64")
        set(QT5_PACKAGES_EXTRA icu)
        if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
            set(QT5_DIR_PREFIX "${QT5_DOWNLOAD_VERSION}/gcc_64")
            set(QT5_PACKAGE_NAME "qt.qt5.${QT5_DOWNLOAD_VERSION_DOTLESS}.gcc_64")
        else()
            message(ERROR "Target platform \"${CMAKE_SYSTEM_NAME}\" is not supported!")
        endif()
    elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Darwin") # macOS
        set(QT5_DOWNLOAD_URL_OS "mac_x64")
        if("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin") # macOS
            set(QT5_DIR_PREFIX "${QT5_DOWNLOAD_VERSION}/clang_64")
            set(QT5_PACKAGE_NAME "qt.qt5.${QT5_DOWNLOAD_VERSION_DOTLESS}.clang_64")
        else()
            message(ERROR "Target platform \"${CMAKE_SYSTEM_NAME}\" is not supported!")
        endif()
    elseif("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows")
        set(QT5_DOWNLOAD_URL_OS "windows_x86")
        if("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
            if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 8) # 64-bit
                set(QT5_DIR_PREFIX "${QT5_DOWNLOAD_VERSION}/msvc2017_64")
                set(QT5_PACKAGE_NAME "qt.qt5.${QT5_DOWNLOAD_VERSION_DOTLESS}.win64_msvc2017_64")
            elseif(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4) # 32-bit
                set(QT5_DIR_PREFIX "${QT5_DOWNLOAD_VERSION}/msvc2017")
                set(QT5_PACKAGE_NAME "qt.qt5.${QT5_DOWNLOAD_VERSION_DOTLESS}.win32_msvc2017")
            else()
                message(ERROR "Compiler is not supported!")
            endif()
        else()
            message(ERROR "Target platform \"${CMAKE_SYSTEM_NAME}\" is not supported!")
        endif()
    else()
        message(ERROR "Host platform \"${CMAKE_HOST_SYSTEM_NAME}\" is not supported!")
    endif()

    set(QT5_BASE_URL "https://download.qt.io/online/qtsdkrepository")
    set(QT5_DOWNLOAD_URL "${QT5_BASE_URL}/${QT5_DOWNLOAD_URL_OS}/desktop/qt5_${QT5_DOWNLOAD_VERSION_DOTLESS}")
    set(QT5_UPDATES_XML_FILE "${QT5_INSTALL_PREFIX}/tmp/Updates.xml")
    if(NOT EXISTS "${QT5_UPDATES_XML_FILE}")
        file(DOWNLOAD "${QT5_DOWNLOAD_URL}/Updates.xml" "${QT5_UPDATES_XML_FILE}" SHOW_PROGRESS)
    endif()
    file(READ "${QT5_UPDATES_XML_FILE}" QT5_UPDATES_XML)
    set(QT5_UPDATES_XML_REGEX "<Name>${QT5_PACKAGE_NAME}.*<Version>([0-9+-.]+)</Version>.*<DownloadableArchives>qtbase([a-zA-Z0-9_-]+).7z")
    string(REGEX MATCH "${QT5_UPDATES_XML_REGEX}" QT5_UPDATES_XML_OUTPUT "${QT5_UPDATES_XML}")
    set(QT5_PACKAGE_VERSION ${CMAKE_MATCH_1})
    set(QT5_PACKAGE_SUFFIX ${CMAKE_MATCH_2})
    string(REPLACE "-debug-symbols" "" QT5_PACKAGE_SUFFIX "${QT5_PACKAGE_SUFFIX}")

    # Workaround for CMake's greedy regex
    if (MSVC AND (CMAKE_SIZEOF_VOID_P EQUAL 4))
        string(REPLACE "X86_64" "X86" QT5_PACKAGE_SUFFIX "${QT5_PACKAGE_SUFFIX}")
    endif()

    foreach(package ${QT5_PACKAGES} ${QT5_PACKAGES_EXTRA})
        if ("${package}" STREQUAL "icu")
            set(package_url "${QT5_DOWNLOAD_URL}/${QT5_PACKAGE_NAME}/${QT5_PACKAGE_VERSION}${package}-linux-Rhel7.2-x64.7z")
        else()
            set(package_url "${QT5_DOWNLOAD_URL}/${QT5_PACKAGE_NAME}/${QT5_PACKAGE_VERSION}${package}${QT5_PACKAGE_SUFFIX}.7z")
        endif()

        set(package_local_file "${QT5_INSTALL_PREFIX}/tmp/${package}.7z")

        if(NOT EXISTS "${package_local_file}")
            message(STATUS "Downloading \"${package}\" package: ${package_url}")
            file(DOWNLOAD "${package_url}" "${package_local_file}" SHOW_PROGRESS)
            execute_process(
                COMMAND ${CMAKE_COMMAND} -E tar xvf "${package_local_file}"
                OUTPUT_QUIET
                WORKING_DIRECTORY "${QT5_INSTALL_PREFIX}"
            )
            message(STATUS "Package \"${package}\" saved to ${package_local_file}")
        else()
            message(STATUS "Package \"${package}\" is already downloaded: ${package_local_file}")
        endif()

        unset(package_url)
        unset(package_local_file)
    endforeach()

    file(READ "${QT5_INSTALL_PREFIX}/${QT5_DIR_PREFIX}/mkspecs/qconfig.pri" qtconfig)
    string(REPLACE "Enterprise" "OpenSource" qtconfig "${qtconfig}")
    string(REPLACE "licheck.exe" "" qtconfig "${qtconfig}")
    string(REPLACE "licheck64" "" qtconfig "${qtconfig}")
    string(REPLACE "licheck_mac" "" qtconfig "${qtconfig}")
    file(WRITE "${QT5_INSTALL_PREFIX}/${QT5_DIR_PREFIX}/mkspecs/qconfig.pri" "${qtconfig}")

    set(ENV{Qt5_DIR} "${QT5_INSTALL_PREFIX}/${QT5_DIR_PREFIX}/lib/cmake/Qt5")
    set(Qt5_DIR "$ENV{Qt5_DIR}" CACHE STRING "Qt5 path hint for CMake" FORCE)
    set(Qt5_DIR "$ENV{Qt5_DIR}")
endfunction()
