# Initialize C standard
if(NOT CMAKE_C_STANDARD)
    set(CMAKE_C_STANDARD 11)
    set(CMAKE_C_STANDARD_REQUIRED ON)
endif()

# Initialize C++ standard
if(NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 14)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

# Don't use e.g. GNU extensions (like -std=gnu++11) for portability
set(CMAKE_CXX_EXTENSIONS OFF)
