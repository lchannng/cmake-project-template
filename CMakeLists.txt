cmake_minimum_required(VERSION 3.0)

# CMP0091 - runtime  (https://cmake.org/cmake/help/v3.15/policy/CMP0091.html)
if (POLICY CMP0091)
    cmake_policy(SET CMP0091 NEW)
endif ()

if(DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
else()
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg)
        set(VCPKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg)
    else()
        message(FATAL_ERROR "Please specify path to vcpkg root directory")
    endif()
endif()
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")

project (cmake-cpp-template)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

if(MSVC)
    # 1. Clear the default content of CMAKE_MSVC_RUNTIME_LIBRARY
    set(CMAKE_MSVC_RUNTIME_LIBRARY "")

	# 2. Set the compiler options for the static multithreaded version.
	add_compile_options($<$<CONFIG:>:/MT> $<$<CONFIG:Debug>:/MTd> $<$<CONFIG:Release>:/MT>)
endif()

# guard against in-source builds and bad build-type strings
include(safeguards)

# include source helpers.
include(utils)

# default compiler flags
include(compilerflags)

add_executable(main src/main.cc)
target_include_directories(main PRIVATE include)

# Print build infomation
include(buildinfo)
