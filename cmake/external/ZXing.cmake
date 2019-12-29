# ZXing

set(ZXing_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DBUILD_SHARED_LIBRARY:BOOL=OFF
    -DENABLE_ENCODERS:BOOL=TRUE
    -DENABLE_DECODERS:BOOL=TRUE
)

if(CMAKE_TOOLCHAIN_FILE)
    list(INSERT ZXing_CMAKE_ARGS 0 "-DCMAKE_TOOLCHAIN_FILE:PATH=${CMAKE_TOOLCHAIN_FILE}")
endif()

if (MSVC)
    list(INSERT ZXing_CMAKE_ARGS 0 "-DLINK_CPP_STATICALLY:BOOL=TRUE")
endif()

ExternalProject_Add(ZXing
    GIT_REPOSITORY "https://github.com/nu-book/zxing-cpp.git"
    GIT_TAG master # TODO: set to "v1.0.8" or higher
    GIT_SHALLOW TRUE
    GIT_PROGRESS FALSE

    UPDATE_COMMAND ""
    PATCH_COMMAND ""

    CMAKE_ARGS ${ZXing_CMAKE_ARGS}

    # CONFIGURE_COMMAND (use default)
    # BUILD_COMMAND (use default)
    BUILD_ALWAYS FALSE
    TEST_COMMAND ""
    # INSTALL_COMMAND (use default)
)

ExternalProject_Get_property(ZXing INSTALL_DIR)
get_filename_component(ZXing_DIR "${INSTALL_DIR}" ABSOLUTE CACHE)
set(ZXing_INCLUDE_DIRS "${ZXing_DIR}/include")
set(ZXing_STATIC_LIBRARY "${ZXing_DIR}/lib/libZXingCore${CMAKE_STATIC_LIBRARY_SUFFIX}")
mark_as_advanced(ZXing_DIR ZXing_INCLUDE_DIRS ZXing_STATIC_LIBRARY)

add_library(ZXing::Core STATIC IMPORTED)
add_dependencies(ZXing::Core ZXing)
set_target_properties(ZXing::Core PROPERTIES IMPORTED_LOCATION "${ZXing_STATIC_LIBRARY}")
