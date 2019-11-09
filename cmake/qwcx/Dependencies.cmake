include(ExternalProject)
set_directory_properties(PROPERTIES EP_BASE "${PROJECT_BINARY_DIR}/CMakeExternalProjects")

include(FetchContent)
set(FETCHCONTENT_BASE_DIR "${PROJECT_BINARY_DIR}/CMakeFetchContent" CACHE PATH "FetchContent" FORCE)

include(external/Qt5)
include(external/ZXing)
