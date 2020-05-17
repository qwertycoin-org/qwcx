set(TARGET_NAME "${PROJECT_NAME_CAMELCASE}Framework_Core")
set(TARGET_NAME_ALIAS "${PROJECT_NAME_CAMELCASE}Framework::Core")
set(TARGET_OUTPUT_NAME "${PROJECT_NAME_LOWERCASE}coreplugin")
set(TARGET_MOC_OPTIONS "-Muri=${PROJECT_NAME_CAMELCASE}.Core")

qtquick_compiler_add_resources(
    TARGET_COMPILED_QRC
    "${CMAKE_CURRENT_LIST_DIR}/qwcxcoreplugin.qrc"
)

set(TARGET_SRC
    "${CMAKE_CURRENT_LIST_DIR}/private/abstractlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/chinesesimplifiedlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/dutchlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/englishlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/frenchlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/germanlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/italianlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/japaneselanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/private/polishlanguage.h"
    "${CMAKE_CURRENT_LIST_DIR}/qwcx.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/qwcx.h"
    "${CMAKE_CURRENT_LIST_DIR}/qwcxcoreplugin.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/qwcxcoreplugin.h"
    "${CMAKE_CURRENT_LIST_DIR}/qwcxmnemonics.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/qwcxmnemonics.h"
    ${TARGET_COMPILED_QRC}
)

set(TARGET_INCLUDE_DIRS
    PUBLIC
    "${Qt5Core_INCLUDE_DIRS}"
    "${Qt5Qml_INCLUDE_DIRS}"
    "${Qt5Quick_INCLUDE_DIRS}"
    "${Qt5Widgets_INCLUDE_DIRS}"
    "${${PROJECT_NAME_CAMELCASE}_INCLUDE_DIRS}"
)
list(REMOVE_DUPLICATES TARGET_INCLUDE_DIRS)

set(TARGET_LINK_LIBS
    PUBLIC
    Qt5::Core
    Qt5::Qml
    Qt5::Quick
    Qt5::Widgets
)

set(TARGET_COMPILE_DEFS
    PRIVATE
    -DQT_NO_CAST_FROM_ASCII
    -DQT_NO_CAST_TO_ASCII
    -DQT_NO_CAST_FROM_BYTEARRAY
    -DQT_NO_URL_CAST_FROM_STRING
    -DQT_STATICPLUGIN
)

add_library(${TARGET_NAME} STATIC)
add_library(${TARGET_NAME_ALIAS} ALIAS ${TARGET_NAME})
target_sources(${TARGET_NAME} PRIVATE ${TARGET_SRC})
target_include_directories(${TARGET_NAME} ${TARGET_INCLUDE_DIRS})
target_link_libraries(${TARGET_NAME} ${TARGET_LINK_LIBS})
target_compile_definitions(${TARGET_NAME} ${TARGET_COMPILE_DEFS})

set_target_properties(
    ${TARGET_NAME}
    PROPERTIES
    OUTPUT_NAME "${TARGET_OUTPUT_NAME}"
    AUTOMOC_MOC_OPTIONS "${TARGET_MOC_OPTIONS}"
)
