cmake_minimum_required(VERSION 3.12)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(qwcx/CompilerSettings)
include(qwcx/Credentials) # Initialize PROJECT_* variables

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)

include(qwcx/Utils) # Provides a set of useful methods
include(qwcx/Platform) # Initialize host and target platform variables
include(qwcx/Dependencies) # Initialize external dependencies

# The name of the distribution package file, not including the extension.
set(PROJECT_PACKAGE_FILE_NAME "${PROJECT_NAME}")
string(APPEND PROJECT_PACKAGE_FILE_NAME "-v${PROJECT_VERSION}")
string(APPEND PROJECT_PACKAGE_FILE_NAME "-${PROJECT_OS_NAME}")
string(APPEND PROJECT_PACKAGE_FILE_NAME "-${PROJECT_ARCH_NAME}")

add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/lib")
add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src")

# Path to directory containing distribution artifacts.
set(PROJECT_DIST_DIR "${CMAKE_CURRENT_BINARY_DIR}/dist")
if(NOT EXISTS "${PROJECT_DIST_DIR}")
    set(PROJECT_CHANGELOG_FILE "${CMAKE_CURRENT_LIST_DIR}/dist/changelog-${PROJECT_VERSION}.md")

    file(MAKE_DIRECTORY "${PROJECT_DIST_DIR}")
    file(COPY "${PROJECT_CHANGELOG_FILE}" DESTINATION "${PROJECT_DIST_DIR}")
    file(WRITE "${PROJECT_DIST_DIR}/version.txt" "${PROJECT_VERSION}")

    unset(PROJECT_CHANGELOG_FILE)
endif()
unset(PROJECT_DIST_DIR)

# Additional import path used to resolve QML modules in Qt Creator's code model
set(QML_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib CACHE STRING "" FORCE)
# Additional import path used to resolve QML modules just for Qt Quick Designer
set(QML_DESIGNER_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib CACHE STRING "" FORCE)
