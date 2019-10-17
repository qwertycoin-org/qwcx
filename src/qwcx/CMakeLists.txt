# Executable_QWCX

set(QWCX_TARGET_DISPLAY_NAME "${PROJECT_DISPLAY_NAME}")
set(QWCX_TARGET_NAME "${PROJECT_NAME}")
set(QWCX_TARGET_NAME_CAMELCASE "${PROJECT_NAME_CAMELCASE}")
set(QWCX_TARGET_NAME_LOWERCASE "${PROJECT_NAME_LOWERCASE}")
set(QWCX_TARGET_VERSION "${PROJECT_VERSION}")
set(QWCX_TARGET_VENDOR_DOMAIN "qwertycoin.org")
set(QWCX_TARGET_VENDOR_DOMAIN_REVERSED "org.qwertycoin")
set(QWCX_TARGET_VENDOR_NAME "Qwertycoin")

set(TARGET_NAME "Executable_${QWCX_TARGET_NAME_CAMELCASE}")

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
    ${TARGET_COMPILED_QRC}
)

set(TARGET_INCLUDE_DIRS
    PRIVATE
    "${Qt5Core_INCLUDE_DIRS}"
    "${Qt5Qml_INCLUDE_DIRS}"
    "${Qt5Widgets_INCLUDE_DIRS}"
)

set(TARGET_LINK_LIBS
    PRIVATE
    Qt5::Core
    Qt5::Qml
    Qt5::Widgets
)

set(TARGET_COMPILE_DEFS
    PRIVATE
    -DQT_NO_CAST_FROM_ASCII
    -DQT_NO_CAST_TO_ASCII
    -DQT_NO_CAST_FROM_BYTEARRAY
    -DQT_NO_URL_CAST_FROM_STRING
)

add_executable(${TARGET_NAME} WIN32 MACOSX_BUNDLE)
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

if(LINUX) # Linux
    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_NAME_LOWERCASE}"
    )
elseif(APPLE) # macOS
    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_DISPLAY_NAME}"
    )
elseif(WIN32) # Windows
    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES
        OUTPUT_NAME "${QWCX_TARGET_DISPLAY_NAME}"
    )
else() # unknown OS
    message(ERROR "Unknown (or unsupported) OS! Can't continue! Sorry.")
endif()
