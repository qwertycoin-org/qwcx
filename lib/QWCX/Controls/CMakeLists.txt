# Framework::Controls

set(TARGET_NAME "${PROJECT_NAME_CAMELCASE}Framework_Controls")
set(TARGET_NAME_ALIAS "${PROJECT_NAME_CAMELCASE}Framework::Controls")

qtquick_compiler_add_resources(
    TARGET_COMPILED_QRC
    "${CMAKE_CURRENT_LIST_DIR}/qmlcontrols.qrc"
)

set(TARGET_SRC
    "${CMAKE_CURRENT_LIST_DIR}/qmlcontrols_plugin.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/qmlcontrols_plugin.h"
    ${TARGET_COMPILED_QRC}
)

set(TARGET_INCLUDE_DIRS
    PUBLIC
    "${Qt5Core_INCLUDE_DIRS}"
    "${Qt5Qml_INCLUDE_DIRS}"
    "${${PROJECT_NAME_CAMELCASE}_INCLUDE_DIRS}"
)

set(TARGET_LINK_LIBS
    PRIVATE
    Qt5::Core
    Qt5::Qml
)

set(TARGET_COMPILE_DEFS
    PRIVATE
    -DQT_NO_CAST_FROM_ASCII
    -DQT_NO_CAST_TO_ASCII
    -DQT_NO_CAST_FROM_BYTEARRAY
    -DQT_NO_URL_CAST_FROM_STRING
)

add_library(${TARGET_NAME} STATIC)
add_library(${TARGET_NAME_ALIAS} ALIAS ${TARGET_NAME})
target_sources(${TARGET_NAME} PRIVATE ${TARGET_SRC})
target_include_directories(${TARGET_NAME} ${TARGET_INCLUDE_DIRS})
target_link_libraries(${TARGET_NAME} ${TARGET_LINK_LIBS})
target_compile_definitions(${TARGET_NAME} ${TARGET_COMPILE_DEFS})
