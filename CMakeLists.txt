cmake_minimum_required(VERSION 3.12)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(qwcx/CompilerSettings)
include(qwcx/Credentials) # Initialize PROJECT_* variables

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)

include(qwcx/Utils) # Provides a set of useful methods
include(qwcx/Platform) # Initialize host and target platform variables
include(qwcx/Dependencies) # Initialize external dependencies

# The name of the distribution package file, not including the extension.
set(PROJECT_PACKAGE_FILE_NAME "${PROJECT_NAME}-v${PROJECT_VERSION}-${PROJECT_OS_NAME}")

add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/lib")
add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src")

# Additional import path used to resolve QML modules in Qt Creator's code model
set(QML_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib CACHE STRING "" FORCE)
# Additional import path used to resolve QML modules just for Qt Quick Designer
set(QML_DESIGNER_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib CACHE STRING "" FORCE)

set(PROJECT_CACHE_FILE "${CMAKE_CURRENT_BINARY_DIR}/cmake_project.cmake")
if(NOT EXISTS "${PROJECT_CACHE_FILE}")
    message(STATUS "Writing to PROJECT_CACHE_FILE: ${PROJECT_CACHE_FILE}")
    file(WRITE "${PROJECT_CACHE_FILE}" "# WARNING: Do not edit! Automatically generated file!\n")
    file(APPEND "${PROJECT_CACHE_FILE}" "set(PROJECT_NAME \"${PROJECT_NAME}\")\n")
    file(APPEND "${PROJECT_CACHE_FILE}" "set(PROJECT_VERSION \"${PROJECT_VERSION}\")\n")
    file(APPEND "${PROJECT_CACHE_FILE}" "set(PROJECT_OS_NAME \"${PROJECT_OS_NAME}\")\n")
    file(APPEND "${PROJECT_CACHE_FILE}" "set(PROJECT_PACKAGE_FILE_NAME \"${PROJECT_PACKAGE_FILE_NAME}\")\n")
endif()
unset(PROJECT_CACHE_FILE)
