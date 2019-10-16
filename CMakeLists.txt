cmake_minimum_required(VERSION 3.12)

if(POLICY CMP0087)
    # Enable generator expressions inside "install(CODE|SCRIPT)".
    cmake_policy(SET CMP0087 NEW)
endif()

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(qwcx/CompilerSettings)
include(qwcx/Credentials) # Initialize PROJECT_* variables

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)

include(qwcx/Dependencies) # Initialize external dependencies

add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src")

# Additional import path used to resolve QML modules in Qt Creator's code model
set(QML_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib CACHE STRING "" FORCE)
# Additional import path used to resolve QML modules just for Qt Quick Designer
set(QML_DESIGNER_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR}/lib CACHE STRING "" FORCE)
