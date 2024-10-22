cmake_minimum_required(VERSION 3.20)

# CMP0091 - runtime  (https://cmake.org/cmake/help/v3.15/policy/CMP0091.html)
if (POLICY CMP0091)
    cmake_policy(SET CMP0091 NEW)
endif ()

project (cmake-cpp-template)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# guard against in-source builds and bad build-type strings
include(safeguards)

# default compiler flags
include(compilerflags)

add_executable(main src/main.cc)
target_include_directories(main PRIVATE include)

# Print build infomation
include(buildinfo)
